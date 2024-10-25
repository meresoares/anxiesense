import React, { useEffect, useState } from 'react';
import Layout from '../../components/layout-component';
import axios from 'axios';
import { useAuth } from '../../services/auth-service';
import CardComponent from '../../components/card-component';
import { isValid, parse, parseISO } from 'date-fns';

interface Respuesta {
    id_persona: string;
    evaluacion: string;
    fecha_evaluacion: Date | null;
    fecha_nacimiento: string | null;
    carrera: string;
}

const HomeAdmin: React.FC = () => {
    const [respuestas, setRespuestas] = useState<Respuesta[]>([]);
    const [rangoEdad, setRangoEdad] = useState<[number, number]>([18, 35]);
    const [criterioAgrupacion, setCriterioAgrupacion] = useState<string>('ninguno');
    const [evaluacionSeleccionada, setEvaluacionSeleccionada] = useState<string>('');
    const { user, logout } = useAuth();
    const API_BASE_URL = 'http://localhost:3001/api';


    useEffect(() => {
        const fetchRespuestas = async () => {
            try {
                const response = await axios.get(`${API_BASE_URL}/evaluaciones`);
                const respuestasData = response.data;

                console.log('Respuestas data:', respuestasData);

                const respuestasConFechas = respuestasData.map((respuesta: any) => ({
                    id_persona: respuesta.id_persona,
                    evaluacion: respuesta.evaluacion,
                    fecha_nacimiento: respuesta.fecha_nacimiento ? new Date(respuesta.fecha_nacimiento) : null,
                    fecha_evaluacion: respuesta.fecha_evaluacion ? respuesta.fecha_evaluacion.toString() : null,
                    carrera: respuesta.carrera,
                }));

                setRespuestas(respuestasConFechas as Respuesta[]);
            } catch (error) {
                console.error('Error al obtener las respuestas:', error);
                setRespuestas([]);
            }
        };

        fetchRespuestas();
    }, [user?.uid]);

    const parseFecha = (fecha: Date | string | null): Date | null => {
        console.log('Fecha recibida:', fecha); // Agrega este console.log
        if (!fecha) return null;
        if (typeof fecha === 'string') {
            const parsedDate = parseISO(fecha);
            console.log('Fecha parsed:', parsedDate); // Agrega este console.log
            return isValid(parsedDate) ? parsedDate : null;
        }
        return isValid(fecha) ? fecha : null;
    };

    // Filtrar y agrupar las respuestas
    const respuestasFiltradasYOrdenadas = () => {
        let respuestasFiltradas = respuestas.filter((respuesta) => {
            const edad = respuesta.fecha_nacimiento ? new Date().getFullYear() - new Date(respuesta.fecha_nacimiento).getFullYear() : 0;
            return edad >= rangoEdad[0] && edad <= rangoEdad[1];
        });

        if (evaluacionSeleccionada) {
            respuestasFiltradas = respuestasFiltradas.filter((respuesta) => respuesta.evaluacion === evaluacionSeleccionada);
        }

        if (criterioAgrupacion === 'edad') {
            respuestasFiltradas = respuestasFiltradas.sort((a, b) => {
                const edadA = a.fecha_nacimiento ? new Date().getFullYear() - new Date(a.fecha_nacimiento).getFullYear() : 0;
                const edadB = b.fecha_nacimiento ? new Date().getFullYear() - new Date(b.fecha_nacimiento).getFullYear() : 0;
                return edadA - edadB;
            });
        } else if (criterioAgrupacion === 'evaluacion') {
            respuestasFiltradas = respuestasFiltradas.sort((a, b) => a.evaluacion.localeCompare(b.evaluacion));
        }

        return respuestasFiltradas;
    };

    return (
        <Layout user={user} handleLogout={logout} title='Bienvenido a AnxiSense' subtitle=''>
            <div className="container">
                <div className='vlad_result_title'>
                    <h2>Tests Realizados</h2>
                </div>

                {/* Filtros */}
                <div className="text-center mb-4">
                    <div className="text-center mb-4">
                        <div className="d-flex justify-content-center">
                            <div className="mb-3 mx-2">
                                <label htmlFor="criterioAgrupacion" className="form-label">Ordenar por:</label>
                                <select
                                    className="form-select w-30"
                                    value={criterioAgrupacion}
                                    onChange={(e) => setCriterioAgrupacion(e.target.value)}
                                >
                                    <option value="ninguno"></option>
                                    <option value="edad">Edad (Menor a Mayor)</option>
                                    <option value="evaluacion">Evaluación</option>
                                </select>
                            </div>
                            <div className="mb-3 mr-2">
                                <label htmlFor="rangoEdad" className="form-label">Filtrar por Rango de Edad:</label>
                                <div className="d-flex">
                                    <input
                                        type="number"
                                        className="form-control w-35"
                                        min="18"
                                        max="35"
                                        value={rangoEdad[0]}
                                        onChange={(e) => setRangoEdad([Number(e.target.value), rangoEdad[1]])}
                                    />
                                    <span className="mx-2">-</span>
                                    <input
                                        type="number"
                                        className="form-control w-35"
                                        min="18"
                                        max="35"
                                        value={rangoEdad[1]}
                                        onChange={(e) => setRangoEdad([rangoEdad[0], Number(e.target.value)])}
                                    />
                                </div>
                            </div>

                            <div className="mb-2 mx-2">
                                <label htmlFor="evaluacion" className="form-label">Filtrar por Evaluación:</label>
                                <select
                                    className="form-select w-30"
                                    value={evaluacionSeleccionada}
                                    onChange={(e) => setEvaluacionSeleccionada(e.target.value)}
                                >
                                    <option value=""></option>
                                    <option value="Ansiedad Social Baja">Ansiedad Social Baja</option>
                                    <option value="Ansiedad Social Moderada">Ansiedad Social Moderada</option>
                                    <option value="Ansiedad Social Alta">Ansiedad Social Alta</option>
                                    {/* Agrega más opciones según sea necesario */}
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                {/* Mostrar las respuestas */}
                {respuestasFiltradasYOrdenadas().length === 0 ? (
                    <div>
                        <p style={{ textAlign: 'center' }}>No hay respuestas disponibles.</p>
                        <img src='/images/empty.png' alt="no hay datos" style={{ display: 'block', margin: '0 auto' }} />
                    </div>
                ) : (
                    <div className="row">
                        <p className="detalles_title">{`Resultados: ${respuestasFiltradasYOrdenadas().length} evaluaciones`}</p>
                        {respuestasFiltradasYOrdenadas().map((respuesta, index) => (
                            <div key={index} className="col-md-4 mb-3">
                                <CardComponent
                                    idPersona={respuesta.id_persona}
                                    evaluacion={respuesta.evaluacion}
                                    fechaEvaluacion={parseFecha(respuesta.fecha_evaluacion ? respuesta.fecha_evaluacion.toString() : null)}
                                    fechaNacimiento={respuesta.fecha_nacimiento}
                                    carrera={respuesta.carrera}
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
