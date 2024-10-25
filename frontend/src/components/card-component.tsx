import React from 'react';
import { useNavigate } from 'react-router-dom';
import { format, isValid, parseISO } from 'date-fns';

interface CardProps {
    idPersona: string;
    evaluacion: string;
    fechaEvaluacion: Date | string | null;
    fechaNacimiento: Date | string | null;
    carrera: string; // Incluimos la carrera como parte de las props
}

const CardComponent: React.FC<CardProps> = ({ idPersona, fechaEvaluacion, fechaNacimiento, evaluacion, carrera }) => {
    const navigate = useNavigate();
    console.log(`Fecha de respuesta: ${fechaEvaluacion}`);
    console.log(`Fecha de nacimiento: ${fechaNacimiento}`);

    const parseFecha = (fecha: Date | string | null): Date | null => {
        if (!fecha) return null;
        if (typeof fecha === 'string') {
            const parsedDate = parseISO(fecha);
            return isValid(parsedDate) ? parsedDate : null;
        }
        return isValid(fecha) ? fecha : null;
    };

    const formattedFechaEvaluacion = parseFecha(fechaEvaluacion)
        ? format(parseFecha(fechaEvaluacion)!, 'dd/MM/yyyy')
        : 'Fecha inválida';

    const formattedFechaNacimiento = parseFecha(fechaNacimiento)
        ? format(parseFecha(fechaNacimiento)!, 'dd/MM/yyyy')
        : 'Fecha inválida';

    const handleNavigation = () => {
        console.log('Navigating to details with idPersona:', idPersona);
        navigate(`/detalle/${idPersona}`, { state: { evaluacion, fechaEvaluacion, fechaNacimiento, carrera } });
    };


    return (
        <div className="card-body mere_card mb-2">
            <p className="p_title_bold">Id Usuario</p>
            <small className='text_cut'>{idPersona}</small>
            <p className="p_title_bold">Evaluación</p>
            <small className='small_answer'>{evaluacion}</small>
            <p className='p_title_bold'>Fecha de Respuesta</p>
            <small className='small_answer'>{formattedFechaEvaluacion}</small>
            <p className='p_title_bold'>Fecha de Nacimiento</p>
            <small className='small_answer'>{formattedFechaNacimiento}</small>
            <button className='vlad_details_button' onClick={handleNavigation}>
                Ver más detalles
            </button>
        </div>
    );
};

export default CardComponent;
