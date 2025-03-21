# redis_ecommerce.py
import redis
import json
import uuid
from datetime import datetime

class RedisEcommerceDemo:
    def __init__(self, host='localhost', port=6379, password='savethesemester'):
        self.redis = redis.Redis(
            host=host, 
            port=port, 
            password=password,
            decode_responses=True  # Automaticamente decodifica las respuestas
        )
        
    def ping(self):
        """Verifica la conexión con Redis"""
        return self.redis.ping()

    # Funcionalidad 1: Caché de productos populares
    def increment_product_view(self, product_id):
        """Incrementa el contador de vistas de un producto"""
        self.redis.zincrby('popular_products', 1, product_id)
        
    def get_popular_products(self, count=10):
        """Obtiene los productos más populares"""
        return self.redis.zrevrange('popular_products', 0, count-1, withscores=True)
    
    # Funcionalidad 2: Gestión de carritos
    def add_to_cart(self, user_id, product_id, quantity):
        """Añade un producto al carrito del usuario"""
        cart_key = f'cart:{user_id}'
        self.redis.hincrby(cart_key, product_id, quantity)
        self.redis.expire(cart_key, 86400)  # TTL: 24 horas
        
    def get_cart(self, user_id):
        """Obtiene el contenido del carrito de un usuario"""
        cart_key = f'cart:{user_id}'
        return self.redis.hgetall(cart_key)
        
    def remove_from_cart(self, user_id, product_id):
        """Elimina un producto del carrito del usuario"""
        cart_key = f'cart:{user_id}'
        self.redis.hdel(cart_key, product_id)
    
    # Funcionalidad 3: Gestión de sesiones
    def create_session(self, user_id, session_data):
        """Crea una nueva sesión para el usuario"""
        session_id = f"session:{user_id}:{uuid.uuid4().hex}"
        self.redis.setex(session_id, 3600, json.dumps(session_data))
        return session_id
        
    def get_session(self, session_id):
        """Obtiene los datos de una sesión"""
        session_data = self.redis.get(session_id)
        if session_data:
            return json.loads(session_data)
        return None
        
    def extend_session(self, session_id):
        """Extiende la duración de una sesión"""
        if self.redis.exists(session_id):
            self.redis.expire(session_id, 3600)
            return True
        return False
    
    # Funcionalidad 4: Contador de visitas
    def increment_page_view(self, page_id):
        """Incrementa el contador de visitas de una página"""
        today = datetime.now().strftime('%Y-%m-%d')
        self.redis.hincrby(f'daily_views:{today}', page_id, 1)
        self.redis.hincrby('total_views', page_id, 1)
        
    def get_daily_views(self, page_id=None):
        """Obtiene las vistas diarias de una página o todas las páginas"""
        today = datetime.now().strftime('%Y-%m-%d')
        if page_id:
            return self.redis.hget(f'daily_views:{today}', page_id)
        else:
            return self.redis.hgetall(f'daily_views:{today}')
            
    def get_total_views(self, page_id=None):
        """Obtiene las vistas totales de una página o todas las páginas"""
        if page_id:
            return self.redis.hget('total_views', page_id)
        else:
            return self.redis.hgetall('total_views')
    
    # Métodos auxiliares para la demostración
    def clear_demo_data(self):
        """Limpia todos los datos de demostración"""
        keys = self.redis.keys('cart:*') + self.redis.keys('session:*') + \
               self.redis.keys('daily_views:*') + ['total_views', 'popular_products']
        if keys:
            self.redis.delete(*keys)
        return True
    
    def load_sample_data(self):
        """Carga datos de ejemplo para la demostración"""
        # Productos populares
        products = {
            'product:1001': 'Smartphone XYZ',
            'product:1002': 'Laptop ABC',
            'product:1003': 'Tablet 123',
            'product:1004': 'Smartwatch Ultra',
            'product:1005': 'Auriculares Wireless'
        }
        
        # Guardar nombres de productos
        for prod_id, prod_name in products.items():
            self.redis.set(f'product_name:{prod_id}', prod_name)
        
        # Simular vistas de productos
        views = {
            'product:1001': 120,
            'product:1002': 85,
            'product:1003': 95,
            'product:1004': 65,
            'product:1005': 75
        }
        
        for prod_id, count in views.items():
            self.redis.zadd('popular_products', {prod_id: count})
        
        # Simular carrito de compras
        self.add_to_cart('user123', 'product:1001', 2)
        self.add_to_cart('user123', 'product:1003', 1)
        
        # Simular vistas de páginas
        pages = ['home', 'category:electronics', 'product:1001', 'product:1002', 'cart']
        for page in pages:
            for _ in range(int(50 * (1 + 0.5 * (pages.index(page) / len(pages))))):
                self.increment_page_view(page)
        
        return True