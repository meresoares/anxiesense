// export default AuthProvider;
// auth-provider.tsx

import React from 'react';
import { useAuth } from './auth-service';
import { useNavigate } from 'react-router-dom';

const AuthProvider: React.FC = () => {
    // Obtiene el servicio de autenticación del contexto
    const authService = useAuth();
    
    // Obtiene el usuario autenticado y la función de cierre de sesión del servicio de autenticación
    const user = authService?.user ?? null;
    const logout = authService?.logout ?? null;

    // Obtiene el objeto de historial de navegación de React Router
    const navigate = useNavigate(); 

    // Función para manejar el cierre de sesión del usuario
    const handleLogout = async () => {
        try {
            await logout();
            navigate('/');
            // Redirigir al usuario a la página de inicio después de cerrar sesión
        } catch (error) {
            console.error("Error al cerrar sesión:", error);
        }
    };


    return (
        <div>
            {/* Muestra el estado de autenticación del usuario */}
            {user ? (
                <div>
                    <p>Usuario autenticado como: {user.email}</p>
                    <button onClick={handleLogout}>Cerrar sesión</button>
                </div>
            ) : (
                <p>No hay usuario autenticado</p>
            )}
        </div>
    );
};

export default AuthProvider;
