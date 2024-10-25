// export default AuthService;
// auth-service.tsx

import { createContext, ReactNode, useContext, useState, useEffect } from "react";
import { getAuth, 
    createUserWithEmailAndPassword, 
    signInWithEmailAndPassword, 
    GoogleAuthProvider, 
    signInWithPopup, 
    signOut, 
    User, 
    onAuthStateChanged,
} from "firebase/auth";


// Definir el tipo de contexto para AuthService
interface AuthService {
    user: User | null;
    register: (email: string, password: string) => Promise<void>;
    login: (email: string, password: string) => Promise<void>;
    loginWithGoogle: () => Promise<void>;
    logout: () => Promise<void>;
}

// Crear el contexto de autenticación
export const AuthContext = createContext<AuthService | null>(null);

// Hook para usar el contexto de autenticación
export const useAuth = () => {
    const context = useContext(AuthContext);
    // Si el contexto no está definido, lanzar un error
    if (!context) {
        throw new Error("useAuth debe ser usado dentro de un AuthProvider");
    }
    return context;
};

// Componente proveedor de autenticación
export function AuthProvider({ children }: { children: ReactNode }): JSX.Element {
    const auth = getAuth();

    const [user, setUser] = useState<User | null>(null);

    useEffect(() => {
        // Escuchar los cambios en el estado de autenticación del usuario
        const unsubscribe = onAuthStateChanged(auth, (currentUser) => {
            setUser(currentUser);
        });

        // Limpiar el listener al desmontar el componente
        return () => unsubscribe();
    }, [auth]);


    // Función para registrar un nuevo usuario
    const register = async (email: string, password: string): Promise<void> => {
        try {
            // Intenta registrar un nuevo usuario en Firebase Auth
            const response = await createUserWithEmailAndPassword(auth, email, password);
            // Actualiza el estado local con el usuario registrado
            setUser(response.user);
            console.log("Usuario registrado:", response.user);
        } catch (error) {
            if (error instanceof Error) {
                console.error("Error al registrar usuario:", error.message);
                const errorMessage = getFriendlyErrorMessage(error.message);
                throw new Error(errorMessage);
            } else {
                console.error("Error al registrar usuario:", error);
                throw new Error("Ocurrió un error al registrar el usuario.");
            }
        }
    };

    const login = async (email: string, password: string): Promise<void> => {
        try {
            // Intenta iniciar sesión con el correo electrónico y la contraseña proporcionados
            const response = await signInWithEmailAndPassword(auth, email, password);
            // Actualiza el estado local con el usuario autenticado
            setUser(response.user);
            console.log("Usuario logueado:", response.user);
        } catch (error) {
            if (error instanceof Error) {
                console.error("Error al iniciar sesión:", error.message);
                const errorMessage = getFriendlyErrorMessage(error.message);
                throw new Error(errorMessage);
            } else {
                console.error("Error al iniciar sesión:", error);
                throw new Error("Ocurrió un error al iniciar sesión.");
            }
        }
    };

    const loginWithGoogle = async (): Promise<void> => {
        try {
            // Crea una instancia del proveedor de autenticación de Google
            const provider = new GoogleAuthProvider();
            // Inicia sesión con el proveedor de autenticación de Google utilizando una ventana emergente
            const response = await signInWithPopup(auth, provider);
            // Actualiza el estado local con el usuario autenticado
            setUser(response.user);
            console.log("Usuario logueado con Google:", response.user);
        } catch (error) {
            console.error("Error al iniciar sesión con Google:", error);
            throw new Error("Ocurrió un error al iniciar sesión con Google.");
        }
    };

    const logout = async (): Promise<void> => {
        try {
            // Cierra la sesión del usuario utilizando Firebase Auth
            await signOut(auth);
            // Establece el estado local del usuario como null, indicando que no hay usuario autenticado
            setUser(null);
            console.log("Usuario desconectado");
        } catch (error) {
            console.error("Error al desconectar usuario:", error);
            throw new Error("Ocurrió un error al desconectar al usuario.");
        }
    };

    // Función para obtener mensajes de error amigables
    const getFriendlyErrorMessage = (errorMessage: string): string => {
        if (errorMessage.includes("auth/email-already-in-use")) {
          return "El correo electrónico ya está en uso.";
        } else if (errorMessage.includes("auth/invalid-email")) {
          return "El correo electrónico no es válido.";
        } else if (errorMessage.includes("auth/weak-password")) {
          return "La contraseña es demasiado débil.";
        } else if (errorMessage.includes("auth/user-disabled")) {
          return "La cuenta de usuario ha sido deshabilitada.";
        } else if (errorMessage.includes("auth/user-not-found")) {
          return "No se encontró una cuenta con ese correo electrónico.";
        } else if (errorMessage.includes("auth/wrong-password")) {
          return "La contraseña es incorrecta.";
        }  else if (errorMessage.includes("auth/invalid-credential")) {
            return "El correo electrónico o la contraseña son incorrectos.";
        } else if (errorMessage.includes("auth/network-request-failed")) {
            return "Error de red. Por favor, revisa tu conexión a Internet.";
        } else if (errorMessage.includes("auth/requires-recent-login")) {
            return "Por favor, inicia sesión de nuevo para completar esta acción.";
        } else {
          return "Ocurrió un error inesperado. Por favor, inténtalo de nuevo.";
        }
      };

    // Devuelve el componente con el proveedor y su valor
    return (
        <AuthContext.Provider value={{ user, register, login, loginWithGoogle, logout }}>
            {children}
        </AuthContext.Provider>
    );
}