import React, { useCallback, useEffect, useState } from 'react';
import { useAuth } from '../../services/auth-service';
import axios from 'axios';
import Questions from '../../components/questions-component';
import Layout from '../../components/layout-component';
import { useNavigate } from 'react-router-dom';
import '../../styles/estilo.css';
import '../../styles/test.css';

interface Pregunta {
  id: number;
  descripcion: string;
}

const TestPage: React.FC = () => {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  const API_BASE_URL = 'http://localhost:3001/api';
  const [preguntas, setPreguntas] = useState<Pregunta[]>([]);
  const [respuestas, setRespuestas] = useState<{ [key: number]: string }>({});
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState<number>(0);
  const [loading, setLoading] = useState<boolean>(false);
  const [showAlert, setShowAlert] = useState<boolean>(false);
  const [redirectPath, setRedirectPath] = useState<string | null>(null);
  const [hasAttemptedToAdvance, setHasAttemptedToAdvance] = useState(false);


  useEffect(() => {
    const checkAuth = async () => {
      if (!user) {
        console.log('Usuario no autenticando, redirigiendo...');
        setRedirectPath('/');
        setLoading(false);
        return;
      }

      try {
        const userResponse = await axios.get(`${API_BASE_URL}/persons/${user.uid}`);
        if (userResponse.status === 200 && userResponse.data) {
          try {
            const testResponse = await axios.get(`${API_BASE_URL}/respuestas/${user.uid}`);
            if (testResponse.status === 200 && testResponse.data) {
              setRedirectPath('/result-page'); // El usuario ha completado el test
            } else {
              setRedirectPath(null); // El usuario puede quedarse en la página
            }
          } catch {
            setRedirectPath(null); // El usuario puede quedarse en la página
          }
        } else {
          setRedirectPath('/user-page');
        }
      } catch {
        setRedirectPath('/user-page');
      } finally {
        setLoading(false);
      }
    };

    checkAuth();
  }, [user]);

  useEffect(() => {
    if (redirectPath) {
      navigate(redirectPath);
    }
  }, [redirectPath, navigate]);

  useEffect(() => {
    const fetchPreguntas = async () => {
      setLoading(true);
      try {
        const response = await axios.get(`${API_BASE_URL}/preguntas`);
        setPreguntas(response.data);
      } catch (error) {
        console.error('Error al obtener las preguntas:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchPreguntas();
  }, []);

  const handleChangeRespuesta = useCallback((preguntaId: number, respuesta: string) => {
    setRespuestas((prevRespuestas) => ({
      ...prevRespuestas,
      [preguntaId]: respuesta,
    }));
  }, []);

  const handleNextQuestion = () => {
    const currentPregunta = preguntas[currentQuestionIndex];
    if (!respuestas[currentPregunta?.id]) {
      setHasAttemptedToAdvance(true);
      setShowAlert(true);
      return;
    }
    setHasAttemptedToAdvance(false);
    setShowAlert(false);
    if (currentQuestionIndex < preguntas.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
    }
  };
  /*
    const handleNextQuestion = () => {
      const currentPregunta = preguntas[currentQuestionIndex];
      if (!respuestas[currentPregunta?.id]) {
        setShowAlert(true);
        return;
      }
      setShowAlert(false);
      if (currentQuestionIndex < preguntas.length - 1) {
        setCurrentQuestionIndex(currentQuestionIndex + 1);
      }
    }; */

  const handlePrevQuestion = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(currentQuestionIndex - 1);
    }
  };

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    const allQuestionsAnswered = preguntas.every((pregunta) => respuestas[pregunta.id] !== undefined);

    if (!allQuestionsAnswered) {
      setShowAlert(true);
      return;
    }

    setLoading(true);
    try {
      const personaId = user?.uid;
      const data = {
        persona_id: personaId,
        respuestas: Object.keys(respuestas).map((preguntaId) => ({
          pregunta_id: parseInt(preguntaId),
          respuesta: respuestas[parseInt(preguntaId)],
        })),
      };
      const response = await axios.post(`${API_BASE_URL}/respuestas`, data);
      const resultadoEvaluacion = response.data.resultado;
      navigate('/result-page', { state: { resultado: resultadoEvaluacion } });
      console.log('Respuesta enviada:', response.data);
    } catch (error) {
      console.error('Error al enviar las respuestas:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Layout
      user={user}
      handleLogout={logout}
      title="Inventario de Fobia Social "
      subtitle="Por favor, indique en qué medida le han molestado los siguientes problemas durante las últimas semanas.
        Responda con sinceridad y tómese el tiempo que necesite; no se preocupe, ya que no hay respuestas correctas o incorrectas. Su honestidad nos ayudará a proporcionarle la mejor evaluación posible."
    >
      {hasAttemptedToAdvance && showAlert && (
        <div className="alert alert-warning" role="alert">
          Por favor, responde la pregunta antes de continuar.
        </div>
      )}
      <div className="progress-container">
        <div
          className="progress-bar"
          style={{ width: `${((currentQuestionIndex + 1) / preguntas.length) * 100}%` }}
        />
        <span className="progress-text">{`${currentQuestionIndex + 1} / ${preguntas.length}`}</span>
      </div>
      <div className="content">
        {loading ? (
          <div className="text-center">
            <p>Cargando...</p>
          </div>
        ) : (
          <form onSubmit={handleSubmit}>
            {preguntas.length > 0 && preguntas[currentQuestionIndex] && (
              <Questions
                pregunta={preguntas[currentQuestionIndex]}
                onChangeRespuesta={handleChangeRespuesta}
                respuestaActual={respuestas[preguntas[currentQuestionIndex]?.id]}
              />
            )}
            <div className="navigation-buttons text-center">
              <button
                className="vlad_btn previous"
                type="button"
                onClick={handlePrevQuestion}
                disabled={currentQuestionIndex === 0}
              >
                Anterior
              </button>
              {currentQuestionIndex < preguntas.length - 1 ? (
                <button
                  className="vlad_btn next shadow-sm p-2 mb-1"
                  type="button"
                  onClick={handleNextQuestion}
                >
                  Siguiente
                </button>
              ) : (
                <button
                  className="vlad_btn next"
                  type="submit"
                  disabled={loading}
                >
                  {loading ? 'Guardando...' : 'Guardar y Evaluar'}
                </button>
              )}
            </div>
          </form>
        )}
      </div>
    </Layout>
  );
};

export default TestPage;
