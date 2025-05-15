<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String mensaje = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nombre = request.getParameter("nombre");
        String contrasena = request.getParameter("contrasena");
        
        if (nombre != null && contrasena != null && !nombre.isEmpty() && !contrasena.isEmpty()) {
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Driver MySQL 8+
                String url = "mysql://root:iGpJdndzvbhLAxbISmSznKcIlXPWVYlB@mysql.railway.internal:3306/railway?useSSL=false&serverTimezone=UTC";
                String user = "root";
                String pass = "iGpJdndzvbhLAxbISmSznKcIlXPWVYlB"; // Cambia aquí tu contraseña
                
                conn = DriverManager.getConnection(url, user, pass);
                String sql = "INSERT INTO usuarios (nombre, contrasena) VALUES (?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setString(1, nombre);
                ps.setString(2, contrasena);
                
                int filas = ps.executeUpdate();
                if (filas > 0) {
                    mensaje = "Usuario registrado exitosamente 🎉";
                } else {
                    mensaje = "Error al registrar usuario.";
                }
            } catch (Exception e) {
                mensaje = "Error: " + e.getMessage();
            } finally {
                if (ps != null) try { ps.close(); } catch(Exception e) {}
                if (conn != null) try { conn.close(); } catch(Exception e) {}
            }
        } else {
            mensaje = "Por favor llena todos los campos.";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Registro de Usuario</title>
<style>
  /* Animación de fondo */
  body {
    margin: 0;
    height: 100vh;
    overflow: hidden;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(270deg, #ff6a00, #ee0979, #ff6a00);
    background-size: 600% 600%;
    animation: gradientBG 16s ease infinite;
  }
  @keyframes gradientBG {
    0%{background-position:0% 50%}
    50%{background-position:100% 50%}
    100%{background-position:0% 50%}
  }
  /* Contenedor formulario */
  .container {
    background: rgba(255,255,255,0.9);
    padding: 30px 40px;
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    width: 350px;
  }
  h2 {
    text-align: center;
    color: #333;
    margin-bottom: 25px;
  }
  label {
    display: block;
    margin-bottom: 6px;
    font-weight: 600;
    color: #555;
  }
  input[type=text], input[type=password] {
    width: 100%;
    padding: 10px 12px;
    margin-bottom: 18px;
    border: 2px solid #ddd;
    border-radius: 8px;
    transition: border-color 0.3s ease;
    font-size: 14px;
  }
  input[type=text]:focus, input[type=password]:focus {
    border-color: #ee0979;
    outline: none;
  }
  button {
    width: 100%;
    padding: 12px 0;
    border: none;
    background: #ee0979;
    color: white;
    font-size: 16px;
    font-weight: bold;
    border-radius: 10px;
    cursor: pointer;
    transition: background 0.3s ease;
  }
  button:hover {
    background: #ff6a00;
  }
  .mensaje {
    text-align: center;
    margin-top: 15px;
    font-weight: 600;
    color: #222;
  }
</style>
</head>
<body>
<div class="container">
  <h2>Registrar Usuario</h2>
  <form method="post" action="registro.jsp">
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" required>
    
    <label for="contrasena">Contraseña:</label>
    <input type="password" id="contrasena" name="contrasena" required>
    
    <button type="submit">Registrar</button>
  </form>
  <% if (!mensaje.isEmpty()) { %>
    <div class="mensaje"><%= mensaje %></div>
  <% } %>
</div>
</body>
</html>
