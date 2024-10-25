import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../services/auth-service';
import ResultadoEvaluacion from '../../components/result-evaluation-component';
import axios from 'axios';
import '../../components/layout-component';
import Layout from '../../components/layout-component';
import '../../styles/estilo.css';

const ResultPage: React.FC = () => {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  const API_BASE_URL = 'http://localhost:3001/api';
  const [loading, setLoading] = useState(true);
  const [resultadoState, setResultadoState] = useState<string | null>(null);

  useEffect(() => {
    const fetchUserDetails = async () => {
      if (!user) {
        console.log('Usuario no autenticado, redirigiendo a la página de inicio de sesión');
        navigate('/'); // Redirige a la página de inicio de sesión si el usuario no está autenticado
        return;
      }

      try {
        const resultResponse = await axios.get(`${API_BASE_URL}/respuestas/${user.uid}`);
        if (resultResponse.status === 200 && resultResponse.data.resultado) {
          setResultadoState(resultResponse.data.resultado);
        } else {
          navigate('/test-page'); // Redirige a la página del test si no se encuentra el resultado
        }
      } catch (error) {
        console.error('Error al obtener los detalles del usuario:', error);
        navigate('/test-page'); // Redirige a la página del test en caso de error
      } finally {
        setLoading(false);
      }
    };

    fetchUserDetails();
  }, [user, navigate]);

  if (loading) {
    return <div>Cargando...</div>;
  }

  if (!resultadoState) {
    return <div>No se encontró el resultado de la evaluación.</div>;
  }

  console.log('Renderizando página de resultados con:', resultadoState);

  return (
    <Layout
      user={user}
      handleLogout={logout}
      title="¡Gracias por completar la evaluación!"
      subtitle="Según tus respuestas parece que estás experimentando un nivel de:"
      titleClassName="vlad_result_title"
      subtitleClassName="vlad_result_subtitle"
    >
      <div className="mb-4 center">
        {resultadoState ? (
          <ResultadoEvaluacion resultado={resultadoState} />
        ) : (
          <div>No se pudo cargar el resultado.</div>
        )}
      </div>
    </Layout>
  );
};

export default ResultPage;
