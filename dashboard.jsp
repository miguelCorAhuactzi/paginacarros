<%@ page session="true" %>
<%
    String usuario = (String) session.getAttribute("usuario");
    if(usuario == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 40px;
        }

        h1 {
            color: #333;
        }

        .usuario {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .imagenes {
            display: flex;
            justify-content: center;
            gap: 3.5rem; /* separación entre imágenes */
            margin-bottom: 40px;
        }

        .imagenes a img {
            width: 200px; /* mismo tamaño */
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            transition: transform 0.2s ease;
        }

        .imagenes a img:hover {
            transform: scale(1.05);
        }

        button {
            padding: 10px 20px;
            background-color: #e74c3c;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        button:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <h1>Bienvenido al Dashboard</h1>
    <p class="usuario">Usuario: <b><%= usuario %></b></p>

    <div class="imagenes">
        <a href="carro1.jsp" target="_blank">
            <img src="./450_1000.jpeg" alt="Carro 1">
        </a>
        <a href="carro2.jsp" target="_blank">
            <img src="./images.jpeg" alt="Carro 2">
        </a>
        <a href="predial.jsp" target="_blank">
            <img src="./images (1).jpeg" alt="Predial">
        </a>
    </div>

    <form action="logout.jsp" method="post">
        <button type="submit">Cerrar sesión</button>
    </form>
</body>
</html>
