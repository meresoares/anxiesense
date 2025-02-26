import React, { useEffect, useState } from 'react';
import Layout from '../../components/layout-component';
import axios from 'axios';
import { useAuth } from '../../services/auth-service';
import CardComponent from '../../components/card-component';
import { isValid, parseISO } from 'date-fns';
import { universidades, carrerasPorUniversidad } from '../../components/universities-options-component';

interface Respuesta {
    persona_id: string;

    evaluacion: string;
    fecha_evaluacion: Date | null;
    fecha_nacimiento: string | null;
    carrera: string;
    universidad: string;
    sexo: string;
}

const HomeAdmin: React.FC = () => {
    const [respuestas, setRespuestas] = useState<Respuesta[]>([]);
    const [rangoEdad, setRangoEdad] = useState<[number, number]>([18, 35]);
    const [criterioAgrupacion, setCriterioAgrupacion] = useState<string>('ninguno');
    const [evaluacionSeleccionada, setEvaluacionSeleccionada] = useState<string>('');
    const [sexoSeleccionado, setSexoSeleccionado] = useState<string>('');
    const [universidadSeleccionada, setUniversidadSeleccionada] = useState<string>('');
    const [carreraSeleccionada, setCarreraSeleccionada] = useState<string>('');
    const { user, logout } = useAuth();
    const API_BASE_URL = 'http://localhost:3001/api';

    useEffect(() => {
        const fetchRespuestas = async () => {
            try {
                const sortBy = criterioAgrupacion === 'ninguno'
                    ? undefined
                    : criterioAgrupacion === 'edad-desc'
                        ? 'edad'
                        : criterioAgrupacion;
                const sortOrder = criterioAgrupacion === 'edad-desc' ? 'ASC' : 'DESC';

                console.log('Parámetros enviados:', {
                    edadMin: rangoEdad[0],
                    edadMax: rangoEdad[1],
                    evaluacion: evaluacionSeleccionada || undefined,
                    sexo: sexoSeleccionado || undefined,
                    universidad: universidadSeleccionada || undefined,
                    carrera: carreraSeleccionada || undefined,
                    sortBy,
                    sortOrder,
                });

                const response = await axios.get(`${API_BASE_URL}/evaluaciones`, {
                    params: {
                        edadMin: rangoEdad[0],
                        edadMax: rangoEdad[1],
                        evaluacion: evaluacionSeleccionada || undefined,
                        sexo: sexoSeleccionado || undefined,
                        universidad: universidadSeleccionada || undefined,
                        carrera: carreraSeleccionada || undefined,
                        sortBy,
                        sortOrder,
                    },
                });
                const respuestasData = response.data;

                console.log('Respuestas recibidas en frontend:', respuestasData);

                const respuestasConFechas = respuestasData.map((respuesta: any) => {
                    console.log('Procesando respuesta:', respuesta);
                    return {
                        persona_id: respuesta.persona_id, // Usamos persona_id para la navegación
                        email: respuesta.email || 'Sin email', // Usamos email para la visualización
                        evaluacion: respuesta.evaluacion,
                        fecha_nacimiento: respuesta.persona?.fecha_nacimiento || null,
                        fecha_evaluacion: respuesta.fecha_evaluacion || null,
                        carrera: respuesta.persona?.carrera || '',
                        universidad: respuesta.persona?.universidad || '',
                        sexo: respuesta.persona?.sexo || '',
                    };
                });
                console.log('Respuestas procesadas:', respuestasConFechas);
                setRespuestas(respuestasConFechas);
            } catch (error) {
                console.error('Error al obtener las respuestas:', error);
                setRespuestas([]);
            }
        };

        fetchRespuestas();
    }, [
        user?.uid,
        rangoEdad,
        evaluacionSeleccionada,
        sexoSeleccionado,
        universidadSeleccionada,
        carreraSeleccionada,
        criterioAgrupacion,
    ]);

    const parseFecha = (fecha: Date | string | null): Date | null => {
        console.log('Fecha recibida:', fecha);
        if (!fecha) return null;
        if (typeof fecha === 'string') {
            const parsedDate = parseISO(fecha);
            console.log('Fecha parsed:', parsedDate);
            return isValid(parsedDate) ? parsedDate : null;
        }
        return isValid(fecha) ? fecha : null;
    };

    // Opciones de carreras dinámicas basadas en la universidad seleccionada
    const opcionesCarreras = universidadSeleccionada
        ? carrerasPorUniversidad[universidadSeleccionada as keyof typeof carrerasPorUniversidad] || []
        : [];

    return (
        <Layout user={user} handleLogout={logout} title="Bienvenido a AnxiSense" subtitle="">
            <div className="container">
                <div className="vlad_result_title">
                    <h2>Tests Realizados</h2>
                </div>

                {/* Filtros */}
                <div className="text-center mb-4">
                    <div className="d-flex justify-content-center flex-wrap">
                        {/* Rango de Edad */}
                        <div className="mb-3 mx-2">
                            <label htmlFor="rangoEdad" className="form-label">Rango de Edad:</label>
                            <div className="d-flex">
                                <input
                                    type="number"
                                    className="form-control w-35"
                                    min="18"
                                    max="100" // Ampliamos el rango máximo para mayor flexibilidad
                                    value={rangoEdad[0]}
                                    onChange={(e) => setRangoEdad([Number(e.target.value), rangoEdad[1]])}
                                    placeholder="Mín"
                                />
                                <span className="mx-2">-</span>
                                <input
                                    type="number"
                                    className="form-control w-35"
                                    min="18"
                                    max="100"
                                    value={rangoEdad[1]}
                                    onChange={(e) => setRangoEdad([rangoEdad[0], Number(e.target.value)])}
                                    placeholder="Máx"
                                />
                            </div>
                        </div>
                        {/* Sexo */}
                        <div className="mb-3 mx-2">
                            <label htmlFor="sexo" className="form-label">Sexo:</label>
                            <select
                                className="form-select w-30"
                                value={sexoSeleccionado}
                                onChange={(e) => setSexoSeleccionado(e.target.value)}
                            >
                                <option value="">Todos</option>
                                <option value="M">Masculino</option>
                                <option value="F">Femenino</option>
                            </select>
                        </div>
                        {/* Universidad */}
                        <div className="mb-3 mx-2">
                            <label htmlFor="universidad" className="form-label">Universidad:</label>
                            <select
                                className="form-select w-30"
                                value={universidadSeleccionada}
                                onChange={(e) => {
                                    setUniversidadSeleccionada(e.target.value);
                                    setCarreraSeleccionada('');
                                }}
                            >
                                <option value="">Todas</option>
                                {universidades.map((uni) => (
                                    <option key={uni.value} value={uni.value}>
                                        {uni.label}
                                    </option>
                                ))}
                            </select>
                        </div>
                        {/* Carrera */}
                        <div className="mb-3 mx-2">
                            <label htmlFor="carrera" className="form-label">Carrera:</label>
                            <select
                                className="form-select w-30"
                                value={carreraSeleccionada}
                                onChange={(e) => setCarreraSeleccionada(e.target.value)}
                                disabled={!universidadSeleccionada}
                            >
                                <option value="">Todas</option>
                                {opcionesCarreras.map((carrera) => (
                                    <option key={carrera.value} value={carrera.value}>
                                        {carrera.label}
                                    </option>
                                ))}
                            </select>
                        </div>
                        {/* Evaluación */}
                        <div className="mb-3 mx-2">
                            <label htmlFor="evaluacion" className="form-label">Evaluación:</label>
                            <select
                                className="form-select w-30"
                                value={evaluacionSeleccionada}
                                onChange={(e) => setEvaluacionSeleccionada(e.target.value)}
                            >
                                <option value="">Todas</option>
                                <option value="Ansiedad Social Baja">Baja</option>
                                <option value="Ansiedad Social Moderada">Moderada</option>
                                <option value="Ansiedad Social Alta">Alta</option>
                            </select>
                        </div>
                        {/* Ordenar por */}
                        <div className="mb-3 mx-2">
                            <label htmlFor="criterioAgrupacion" className="form-label">Ordenar por:</label>
                            <select
                                className="form-select w-30"
                                value={criterioAgrupacion}
                                onChange={(e) => setCriterioAgrupacion(e.target.value)}
                            >
                                <option value="ninguno">Ninguno</option>
                                <option value="edad">Edad (Menor a Mayor)</option>
                                <option value="edad-desc">Edad (Mayor a Menor)</option>
                                <option value="evaluacion">Evaluación</option>
                            </select>
                        </div>
                    </div>
                </div>

                {/* Mostrar las respuestas */}
                {respuestas.length === 0 ? (
                    <div>
                        <p style={{ textAlign: 'center' }}>No hay respuestas disponibles.</p>
                        <img src="/images/empty.png" alt="no hay datos" style={{ display: 'block', margin: '0 auto' }} />
                    </div>
                ) : (
                    <div className="row">
                        <p className="detalles_title">{`Resultados: ${respuestas.length} evaluaciones`}</p>
                        {respuestas.map((respuesta) => (
                            <div key={respuesta.persona_id} className="col-md-4 mb-3">
                                <CardComponent
                                    idPersona={respuesta.persona_id}
                                    evaluacion={respuesta.evaluacion}
                                    fechaEvaluacion={parseFecha(respuesta.fecha_evaluacion)}
                                    fechaNacimiento={respuesta.fecha_nacimiento}
                                    carrera={respuesta.carrera}
                                    universidad={respuesta.universidad}
                                    sexo={respuesta.sexo}
                                />
                            </div>
                        ))}
                    </div>
                )}
            </div>
        </Layout>
    );
};

export default HomeAdmin;