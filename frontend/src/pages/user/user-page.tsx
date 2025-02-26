import React, { useState, useRef, useEffect } from 'react';
import axios from 'axios';
import { useAuth } from '../../services/auth-service';
import Layout from '../../components/layout-component';
import { useNavigate } from 'react-router-dom';
import { SexoSelect, FechaNacimientoPicker, UniversidadCarreraSelect } from '../../components/user-component';
import '../../styles/estilo.css';
import DatePicker from 'react-datepicker';
import { differenceInYears, format } from 'date-fns';

const UserPage: React.FC = () => {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  const [startDate, setStartDate] = useState<Date | null>(new Date());
  const datePickerRef = useRef<DatePicker>(null);
  const API_BASE_URL = 'http://localhost:3001/api';
  const [sexo, setSexo] = useState<string>('');
  const [universidad, setUniversidad] = useState<string>('');
  const [carrera, setCarrera] = useState<string>('');
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string>('');

  useEffect(() => {
    const checkIfCompleted = async () => {
      setLoading(true);  // Aquí se activa el estado de loading
      if (!user) return;

      try {
        const response = await axios.get(`${API_BASE_URL}/persons/${user.uid}`);
        if (response.status === 200 && response.data) {
          navigate('/test-page');
        }
      } catch (err) {
        console.error('Error al verificar si la página de usuario está completa:', err);
      } finally {
        setLoading(false);  // Finaliza el estado de loading cuando termina la verificación
      }
    };

    checkIfCompleted();
  }, [user, navigate]);

  const handleSubmit: React.FormEventHandler<HTMLFormElement> = async (event) => {
    event.preventDefault();
    if (!user) {
      setError('No hay un usuario autenticado.');
      return;
    }

    // Validar que todos los campos estén llenos
    if (!sexo || !universidad || !carrera || !startDate) {
      setError('Por favor, completa todos los campos.');
      setLoading(false);
      return;
    }

    // Obtener la fecha actual
    const today = new Date();

    // Verificar la edad del usuario
    if (startDate) {
      const age = differenceInYears(today, startDate);
      if (age < 20 || age > 35) {
        setError('Debes tener entre 20 y 35 años para registrarte.');
        return;
      }
    }

    setError('');
    setLoading(true);  // Se activa el loading cuando se comienza a enviar el formulario

    const formattedDate = format(startDate!, 'yyyy-MM-dd');

    try {
      await axios.post(`${API_BASE_URL}/persons`, {
        id: user.uid,
        sexo,
        fecha_nacimiento: formattedDate,
        universidad,
        carrera,
        tipo_persona_role: 'Usuario',
      });

      navigate('/test-page');

    } catch (error) {
      if (axios.isAxiosError(error)) {
        setError(`Error al enviar los datos: ${error.response?.status} ${error.response?.data?.message}`);
      } else {
        setError('Error al enviar los datos del formulario.');
      }
      console.error('Error:', error);
    } finally {
      setLoading(false);  // Finaliza el estado de loading después de que se completa el envío
    }
  };

  return (
    <Layout
      user={user}
      handleLogout={logout}
      title="Bienvenido a AnxieSense"
      subtitle="AnxieSense es un sistema experto diseñado para ayudarte a comprender mejor tus niveles de ansiedad social. Antes de comenzar, por favor completa el siguiente formulario con tus datos personales. Te garantizamos que toda la información proporcionada será tratada con absoluta confidencialidad, al igual que los resultados de tu evaluación."
    >
      <div className="container">
        <div className="row justify-content-center">
          <div className="col-md-8 col-lg-6">
            {loading ? (  // Mostramos un spinner o mensaje de cargando mientras loading está activado
              <div className="text-center">
                <p>Cargando...</p>
              </div>
            ) : (
              <form onSubmit={handleSubmit}>
                <h4 className="text-center mb-3">Formulario de Información Personal</h4>
                {error && <div className="alert alert-danger mb-3">{error}</div>}
                <div className="mb-3">
                  <SexoSelect sexo={sexo} onChange={setSexo} />
                </div>
                <div className="mb-3">
                  <FechaNacimientoPicker startDate={startDate} onChange={setStartDate} />
                </div>
                <div className="mb-3">
                  <UniversidadCarreraSelect universidad={universidad} carrera={carrera} onChangeUniversidad={setUniversidad} onChangeCarrera={setCarrera} />
                </div>
                <div className="text-center">
                  <button className="btn btn-primary btn-lg" type="submit" disabled={loading}>
                    {loading ? 'Cargando...' : 'Empezar test'}
                  </button>
                </div>
              </form>
            )}
          </div>
        </div>
      </div>
    </Layout>
  );
};

export default UserPage;
