// static/js/main.js

const USER_ID = 'user123';

// Verificar conexión con Redis
async function checkConnection() {
    try {
        const response = await fetch('/api/ping');
        const data = await response.json();
        
        const statusEl = document.getElementById('connectionStatus');
        if (data.status === 'success') {
            statusEl.classList.remove('alert-info', 'alert-danger');
            statusEl.classList.add('alert-success');
            statusEl.textContent = '✓ Conectado a Redis correctamente';
        } else {
            statusEl.classList.remove('alert-info', 'alert-success');
            statusEl.classList.add('alert-danger');
            statusEl.textContent = '✗ Error al conectar con Redis';
        }
    } catch (error) {
        const statusEl = document.getElementById('connectionStatus');
        statusEl.classList.remove('alert-info', 'alert-success');
        statusEl.classList.add('alert-danger');
        statusEl.textContent = '✗ Error al conectar con el servidor';
    }
}

// Cargar productos populares
async function loadPopularProducts() {
    try {
        const response = await fetch('/api/products/popular?count=5');
        const data = await response.json();
        
        const productsEl = document.getElementById('popularProducts');
        productsEl.innerHTML = '';
        
        data.products.forEach(product => {
            const productDiv = document.createElement('div');
            productDiv.className = 'product-item';
            productDiv.innerHTML = `
                <span>${product.id}</span>
                <span class="badge bg-primary">${Math.round(product.views)} vistas</span>
            `;
            productsEl.appendChild(productDiv);
        });
    } catch (error) {
        console.error('Error al cargar productos populares:', error);
    }
}

// Cargar carrito
async function loadCart() {
    try {
        const response = await fetch(`/api/cart/${USER_ID}`);
        const data = await response.json();
        
        const cartEl = document.getElementById('cartItems');
        cartEl.innerHTML = '';
        
        if (Object.keys(data.cart).length === 0) {
            cartEl.innerHTML = '<p>El carrito está vacío</p>';
            return;
        }
        
        for (const [productId, quantity] of Object.entries(data.cart)) {
            const cartItemDiv = document.createElement('div');
            cartItemDiv.className = 'cart-item';
            cartItemDiv.innerHTML = `
                <span>${productId}</span>
                <span>Cantidad: ${quantity}</span>
                <button class="btn btn-sm btn-danger remove-cart-item" data-product="${productId}">Eliminar</button>
            `;
            cartEl.appendChild(cartItemDiv);
        }
        
        // Agregar eventos a los botones de eliminar
        document.querySelectorAll('.remove-cart-item').forEach(button => {
            button.addEventListener('click', function() {
                const productId = this.getAttribute('data-product');
                removeFromCart(productId);
            });
        });
    } catch (error) {
        console.error('Error al cargar el carrito:', error);
    }
}

// Añadir al carrito
async function addToCart() {
    const productId = document.getElementById('productSelect').value;
    const quantity = parseInt(document.getElementById('quantityInput').value);
    
    if (quantity <= 0) {
        alert('La cantidad debe ser mayor que 0');
        return;
    }
    
    try {
        const response = await fetch(`/api/cart/${USER_ID}/add`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ product_id: productId, quantity: quantity })
        });
        
        const data = await response.json();
        if (data.status === 'success') {
            loadCart();
        }
    } catch (error) {
        console.error('Error al añadir al carrito:', error);
    }
}

// Eliminar del carrito
async function removeFromCart(productId) {
    try {
        const response = await fetch(`/api/cart/${USER_ID}/remove`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ product_id: productId })
        });
        
        const data = await response.json();
        if (data.status === 'success') {
            loadCart();
        }
    } catch (error) {
        console.error('Error al eliminar del carrito:', error);
    }
}

// Cargar estadísticas de vistas
async function loadViewsStats() {
    try {
        const response = await fetch('/api/analytics/views');
        const data = await response.json();
        
        // Actualizar vistas diarias
        const dailyViewsEl = document.getElementById('dailyViews');
        dailyViewsEl.innerHTML = '';
        
        for (const [pageId, views] of Object.entries(data.daily_views)) {
            const viewDiv = document.createElement('div');
            viewDiv.className = 'view-count';
            viewDiv.innerHTML = `
                <span>${pageId}: </span>
                <strong>${views} vistas</strong>
            `;
            dailyViewsEl.appendChild(viewDiv);
        }
        
        // Actualizar vistas totales
        const totalViewsEl = document.getElementById('totalViews');
        totalViewsEl.innerHTML = '';
        
        for (const [pageId, views] of Object.entries(data.total_views)) {
            const viewDiv = document.createElement('div');
            viewDiv.className = 'view-count';
            viewDiv.innerHTML = `
                <span>${pageId}: </span>
                <strong>${views} vistas</strong>
            `;
            totalViewsEl.appendChild(viewDiv);
        }
    } catch (error) {
        console.error('Error al cargar estadísticas de vistas:', error);
    }
}

// Registrar vista de página
async function viewPage(pageId) {
    try {
        await fetch(`/api/products/view/${pageId}`);
        loadViewsStats();
    } catch (error) {
        console.error('Error al registrar vista de página:', error);
    }
}

// Cargar datos de demo
async function loadDemoData() {
    try {
        const response = await fetch('/api/demo/load', { method: 'POST' });
        const data = await response.json();
        
        if (data.status === 'success') {
            loadPopularProducts();
            loadCart();
            loadViewsStats();
            alert('Datos de demostración cargados correctamente');
        }
    } catch (error) {
        console.error('Error al cargar datos de demo:', error);
        alert('Error al cargar datos de demo');
    }
}

// Reiniciar demo
async function resetDemo() {
    try {
        const response = await fetch('/api/demo/reset', { method: 'POST' });
        const data = await response.json();
        
        if (data.status === 'success') {
            loadPopularProducts();
            loadCart();
            loadViewsStats();
            alert('Demo reiniciado correctamente');
        }
    } catch (error) {
        console.error('Error al reiniciar demo:', error);
        alert('Error al reiniciar demo');
    }
}

// Inicializar demo
document.addEventListener('DOMContentLoaded', function() {
    // Verificar conexión
    checkConnection();
    
    // Cargar datos iniciales
    loadPopularProducts();
    loadCart();
    loadViewsStats();
    
    // Eventos
    document.getElementById('refreshPopularBtn').addEventListener('click', loadPopularProducts);
    document.getElementById('addToCartBtn').addEventListener('click', addToCart);
    
    document.getElementById('viewHomeBtn').addEventListener('click', () => viewPage('home'));
    document.getElementById('viewElectronicsBtn').addEventListener('click', () => viewPage('category:electronics'));
    document.getElementById('viewProduct1Btn').addEventListener('click', () => viewPage('product:1001'));
    document.getElementById('viewProduct2Btn').addEventListener('click', () => viewPage('product:1002'));
    document.getElementById('viewCartBtn').addEventListener('click', () => viewPage('cart'));
    
    document.getElementById('loadDemoBtn').addEventListener('click', loadDemoData);
    document.getElementById('resetDemoBtn').addEventListener('click', resetDemo);
});