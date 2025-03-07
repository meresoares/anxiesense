// export default RegistroFormulario;
// registroFormulario.tsx

import React, { useState } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useAuth } from '../services/auth-service';
import { Link } from 'react-router-dom';
import { useNavigate } from 'react-router-dom';


const Register: React.FC = () => {
    const auth = useAuth();
    const { register } = useAuth();
    //const [username, setUsername] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [repeatPassword, setRepeatPassword] = useState('');
    const [showPassword, setShowPassword] = useState(false);
    const [showRepeatPassword, setShowRepeatPassword] = useState(false);
    const [error, setError] = useState<string | null>(null);
    const [submitting, setSubmitting] = useState(false); // Estado para controlar el envío del formulario
    const [successMessage, setSuccessMessage] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const navigate = useNavigate();

    // Función para alternar la visibilidad de la contraseña
    const togglePasswordVisibility = () => {
        setShowPassword(!showPassword);
    };

    // Función para alternar la visibilidad de la repetición de contraseña
    const toggleRepeatPasswordVisibility = () => {
        setShowRepeatPassword(!showRepeatPassword);
    };

    // Función para manejar el envío del formulario de registro
    const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
        // Evita que el formulario se envíe automáticamente
        event.preventDefault();
        // Deshabilita el botón de registro mientras se procesa la solicitud
        setSubmitting(true);
        setError('');

        // Validación de campos vacíos
        if (!email || !password || !repeatPassword) {
            setError('Por favor, completa todos los campos obligatorios.');
            // Habilita el botón de registro nuevamente
            setSubmitting(false);
            // Sale temprano de la función
            return;
        }

        // Validación de longitud de la contraseña
        if (password.length < 6) {
            setError('La contraseña debe tener al menos 6 caracteres.');
            // Habilitar el botón de registro nuevamente
            setSubmitting(false);
            return; // Retorno temprano
        }

        try {
            await register(email, password);
            setSuccessMessage('¡Cuenta creada exitosamente!');
            navigate('/');

        } catch (error) {
            if (error instanceof Error) {
                setError(error.message);
            }
        } finally {
            // Habilita el botón de registro nuevamente
            setSubmitting(false);
        }
    };

    // Función para manejar el inicio de sesión con Google
    const handleGoogleLogin = async () => {
        setIsLoading(true);
        setError(null);

        try {
            await auth.loginWithGoogle();
            setSuccessMessage('¡Registrado exitosamente con Google!');
            // Agrega un retraso antes de redirigir
            setTimeout(() => {
                navigate('/');
            }, 3000);
        } catch (error) {
            // Asegurarse de que el error sea tratado como un Error
            if (error instanceof Error) {
                setError(error.message);
            } else {
                setError('Ocurrió un error inesperado');
            }
        } finally {
            // Habilita el botón de registro nuevamente
            setIsLoading(false);
        }

    };


    return (
        <form onSubmit={handleSubmit} style={{ maxWidth: '400px', margin: 'auto' }}>
            <div className="text-center mb-3">
                <h1 className="h3 mb-3 font-weight-normal" style={{ marginTop: '1.5rem' }}>¡Bienvenido a AnxieSense!</h1>
                <h5 className="fw-normal mb-3 pb-3" style={{ letterSpacing: '1px', color: '#666' }}>Crear una cuenta</h5>
            </div>
            {error && <div className="alert alert-danger mb-2">{error}</div>}
            <div className="form-outline inputGroup-sizing-sm mb-2">
                <input type="email" id="email" className="form-control inputGroup-sizing-sm" placeholder='Correo electrónico' value={email} onChange={(e) => setEmail(e.target.value)} />
            </div>
            <div className="input-group mb-2">
                <input
                    type={showPassword ? 'text' : 'password'}
                    id="password" // Cambiamos el id a "password"
                    className="form-control inputGroup-sizing-sm"
                    placeholder="Ingrese una contraseña"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                />
                <label className="form-label" htmlFor="password"></label>
                <span
                    className="input-group-text"
                    style={{ cursor: 'pointer' }}
                    onClick={togglePasswordVisibility}
                >
                    <i className="fas fa-eye" style={{ color: '#666' }}></i>
                </span>
            </div>

            <div className="input-group mb-2">
                <input
                    type={showRepeatPassword ? 'text' : 'password'}
                    id="repeatPassword" // Manteniendo el id único para este campo
                    className="form-control inputGroup-sizing-sm"
                    placeholder="Repetir contraseña"
                    value={repeatPassword}
                    onChange={(e) => setRepeatPassword(e.target.value)}
                />
                <label className="form-label" htmlFor="repeatPassword"></label>
                <span
                    className="input-group-text"
                    style={{ cursor: 'pointer' }}
                    onClick={toggleRepeatPasswordVisibility}
                >
                    <i className="fas fa-eye" style={{ color: '#666' }}></i>
                </span>
            </div>
            <div className="pt-1 mb-3 text-center">
                <button className="btn btn-primary btn-sm btn-block" type="submit" disabled={submitting}>
                    {isLoading ? 'Registrando...' : 'Crear cuenta'}
                </button>
            </div>
            {successMessage && !error && <div className="alert alert-success mb-3">{successMessage}</div>}

            <div className="text-center">
                <small>O Regístrate con:</small>
                <button type="button" className="btn btn-link btn-floating" onClick={handleGoogleLogin}>
                    <i className="fab fa-google fa-2x"></i>
                </button>
            </div>
            {successMessage && <p>{successMessage}</p>}
            <p className="text-center" style={{ color: '#666' }}>¿Ya tienes una cuenta? <Link to="/" style={{ color: '#508bfc' }}>Ingresa aquí</Link></p>
        </form>
    );
};

export default Register;