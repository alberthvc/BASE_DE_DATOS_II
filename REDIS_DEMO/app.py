# app.py
from flask import Flask, jsonify, request, render_template, redirect, url_for
import os
from redis_ecommerce import RedisEcommerceDemo

app = Flask(__name__)
app.secret_key = os.urandom(24)

# Inicializar la conexión a Redis
redis_demo = RedisEcommerceDemo(password='savethesemester')  # Sin contraseña para la demo

@app.route('/')
def index():
    """Página principal"""
    return render_template('index.html')

@app.route('/api/ping')
def ping():
    """Verificar conexión con Redis"""
    return jsonify({"status": "success" if redis_demo.ping() else "error"})

@app.route('/api/products/view/<product_id>')
def view_product(product_id):
    """Registrar vista de producto"""
    redis_demo.increment_product_view(product_id)
    redis_demo.increment_page_view(f'product:{product_id}')
    return jsonify({"status": "success"})

@app.route('/api/products/popular')
def popular_products():
    """Obtener productos populares"""
    count = request.args.get('count', default=10, type=int)
    products = redis_demo.get_popular_products(count)
    return jsonify({"products": [{"id": p[0], "views": p[1]} for p in products]})

@app.route('/api/cart/<user_id>')
def get_cart(user_id):
    """Obtener carrito de compras"""
    cart = redis_demo.get_cart(user_id)
    return jsonify({"cart": cart})

@app.route('/api/cart/<user_id>/add', methods=['POST'])
def add_to_cart(user_id):
    """Añadir producto al carrito"""
    data = request.json
    redis_demo.add_to_cart(user_id, data['product_id'], data['quantity'])
    return jsonify({"status": "success"})

@app.route('/api/cart/<user_id>/remove', methods=['POST'])
def remove_from_cart(user_id):
    """Eliminar producto del carrito"""
    data = request.json
    redis_demo.remove_from_cart(user_id, data['product_id'])
    return jsonify({"status": "success"})

@app.route('/api/analytics/views')
def get_views():
    """Obtener estadísticas de vistas"""
    daily = redis_demo.get_daily_views()
    total = redis_demo.get_total_views()
    return jsonify({
        "daily_views": daily,
        "total_views": total
    })

@app.route('/api/demo/reset', methods=['POST'])
def reset_demo():
    """Reiniciar datos de demostración"""
    redis_demo.clear_demo_data()
    return jsonify({"status": "success"})

@app.route('/api/demo/load', methods=['POST'])
def load_demo():
    """Cargar datos de ejemplo"""
    redis_demo.load_sample_data()
    return jsonify({"status": "success"})

if __name__ == '__main__':
    app.run(debug=True)