import React from 'react';
import { useNavigate } from 'react-router-dom';
import { format, isValid, parseISO, differenceInYears } from 'date-fns';

interface CardProps {
    idPersona: string;
    evaluacion: string;
    fechaEvaluacion: Date | string | null;
    fechaNacimiento: Date | string | null;
    carrera: string;
    universidad?: string;
    sexo?: string;
}

const CardComponent: React.FC<CardProps> = ({
    idPersona,
    fechaEvaluacion,
    fechaNacimiento,
    evaluacion,
    carrera,
    universidad,
    sexo,
}) => {
    const navigate = useNavigate();
    console.log(`Fecha de respuesta: ${fechaEvaluacion}`);
    console.log(`Fecha de nacimiento: ${fechaNacimiento}`);

    const parseFecha = (fecha: Date | string | null): Date | null => {
        if (!fecha) return null;
        if (typeof fecha === 'string') {
            try {
                // Intentamos parsear con parseISO para fechas en formato ISO (ej. 2025-02-23T22:42:18.993Z)
                const parsedDate = parseISO(fecha);
                console.log('Fecha parseada con parseISO:', parsedDate, 'Válida:', isValid(parsedDate));
                return isValid(parsedDate) ? parsedDate : null;
            } catch (error) {
                console.error('Error al parsear fecha:', error, 'Fecha:', fecha);
                // Si parseISO falla, intentamos parsear una fecha en formato 'YYYY-MM-DD' (ej. 1997-12-03)
                const [year, month, day] = fecha.split('-').map(Number);
                if (year && month && day) {
                    const newDate = new Date(year, month - 1, day); // Restamos 1 al mes porque es 0-based
                    console.log('Fecha parseada manualmente:', newDate, 'Válida:', isValid(newDate));
                    return isValid(newDate) ? newDate : null;
                }
                return null;
            }
        }
        console.log('Fecha ya es Date, válida:', isValid(fecha));
        return isValid(fecha) ? fecha : null;
    };

    const calcularEdad = (fechaNac: Date | string | null): string => {
        const fecha = parseFecha(fechaNac);
        if (!fecha) return 'Edad inválida';
        const edad = differenceInYears(new Date(), fecha);
        return `${edad} años`;
    };

    const formattedFechaEvaluacion = parseFecha(fechaEvaluacion)
        ? format(parseFecha(fechaEvaluacion)!, 'dd/MM/yyyy')
        : 'Fecha inválida';

    const formattedFechaNacimiento = parseFecha(fechaNacimiento)
        ? format(parseFecha(fechaNacimiento)!, 'dd/MM/yyyy')
        : 'Fecha inválida';
    const handleNavigation = () => {
        if (!idPersona || typeof idPersona !== 'string') {
            console.error('idPersona es inválido:', idPersona);
            return; // Evitamos navegar si idPersona es undefined o no es string
        }
        console.log('Navigating to details with idPersona:', idPersona);
        navigate(`/detalle/${idPersona}`, {
            state: { evaluacion, fechaEvaluacion, fechaNacimiento, carrera, universidad, sexo },
        });
    };

    return (
        <div className="card-body mere_card mb-2">
            <p className="p_title_bold">Edad</p>
            <small className="small_answer">{calcularEdad(fechaNacimiento)}</small>
            <p className="p_title_bold">Evaluación</p>
            <small className="small_answer">{evaluacion}</small>
            <p className="p_title_bold">Fecha de Respuesta</p>
            <small className="small_answer">{formattedFechaEvaluacion}</small>
            <p className="p_title_bold">Fecha de Nacimiento</p>
            <small className="small_answer">{formattedFechaNacimiento}</small>
            <button className="vlad_details_button" onClick={handleNavigation}>
                Ver más detalles
            </button>
        </div>
    );
};

export default CardComponent;