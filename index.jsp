<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*, javax.servlet.http.*" %>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String mensajeError = null;

    if (email != null && password != null) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String url = "mysql://root:iGpJdndzvbhLAxbISmSznKcIlXPWVYlB@mysql.railway.internal:3306/railway";
        String user = "root";
        String pass = "iGpJdndzvbhLAxbISmSznKcIlXPWVYlB";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pass);

            String sql = "SELECT * FROM usuarios WHERE nombre = ? AND contrasena = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("usuario", email); // Guardamos el nombre en la sesión
                response.sendRedirect("dashboard.jsp");
                return;
            } else {
                mensajeError = "Usuario o contraseña incorrectos.";
            }

        } catch (Exception e) {
            mensajeError = "Error en la conexión: " + e.getMessage();
        } finally {
            if (rs != null) try { rs.close(); } catch(Exception e) {}
            if (ps != null) try { ps.close(); } catch(Exception e) {}
            if (conn != null) try { conn.close(); } catch(Exception e) {}
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login JSP</title>
    <style>
        html { box-sizing: border-box; }
        *, *::before, *::after { box-sizing: inherit; }

        body {
            font-family: Arial, sans-serif;
            color: white;
            margin: 0;
            padding: 0;
            animation: fondo 10s infinite linear;
            background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
            background-size: 400% 400%;
        }

        @keyframes fondo {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .contenedor {
            padding: 50px;
            text-align: center;
        }

        h1, h2 { margin-bottom: 20px; }

        .form-container {
            width: 450px;
            background: linear-gradient(#212121, #212121) padding-box,
                        linear-gradient(145deg, transparent 35%,#e81cff, #40c9ff) border-box;
            border: 2px solid transparent;
            padding: 32px 24px;
            font-size: 14px;
            font-family: inherit;
            color: white;
            display: flex;
            flex-direction: column;
            gap: 20px;
            border-radius: 16px;
        }

        .form-container .form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-container .form-group {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .form-container .form-group label {
            margin-bottom: 5px;
            color: #717171;
            font-weight: 600;
            font-size: 12px;
        }

        .form-container .form-group input {
            width: 100%;
            padding: 12px 16px;
            border-radius: 8px;
            color: #fff;
            background-color: transparent;
            border: 1px solid #414141;
        }

        .form-container .form-group input::placeholder {
            opacity: 0.5;
        }

        .form-container .form-group input:focus {
            outline: none;
            border-color: #e81cff;
        }

        .form-container .form-submit-btn {
            align-self: flex-start;
            color: #717171;
            font-weight: 600;
            width: 40%;
            background: #313131;
            border: 1px solid #414141;
            padding: 12px 16px;
            font-size: inherit;
            cursor: pointer;
            border-radius: 6px;
        }

        .form-container .form-submit-btn:hover {
            background-color: #fff;
            color: black;
            border-color: #fff;
        }

        .enlaces {
            text-align: center;
            margin-top: 15px;
        }

        .enlaces a {
            color: #e0e0e0;
            text-decoration: none;
            margin: 0 10px;
            font-size: 14px;
        }

        .enlaces a:hover {
            text-decoration: underline;
        }

        .mensaje-error {
            color: red;
            font-weight: bold;
            margin-top: -10px;
        }
    </style>
</head>
<body>
    <div class="contenedor">
        <h1>J.Felix Portillo</h1>
        <h2>Bienvenido a tu portal</h2>

        <% if (mensajeError != null) { %>
            <p class="mensaje-error"><%= mensajeError %></p>
        <% } %>

        <center>
        <div class="form-container">
            <form class="form" method="post" action="index.jsp">
                <div class="form-group">
                    <label for="email">Correo electrónico</label>
                    <input type="email" id="email" name="email" required placeholder="correo@ejemplo.com">
                </div>

                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" id="password" name="password" required placeholder="********">
                </div>

                <button class="form-submit-btn" type="submit">Iniciar sesión</button>

                <div class="enlaces">
                    <a href="registro.jsp">Registrarse</a>
                    <a href="recuperar.jsp">¿Olvidaste tu contraseña?</a>
                </div>
            </form>
        </div>
        </center>
    </div>
</body>
</html>
