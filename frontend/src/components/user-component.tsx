import React, { useRef } from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCalendarAlt } from '@fortawesome/free-solid-svg-icons';
import { isValid } from 'date-fns';
import { universidades, carrerasPorUniversidad } from './universities-options-component';
// Definimos la interfaz para FechaNacimientoPicker
interface FechaNacimientoPickerProps {
    startDate: Date | null;
    onChange: (date: Date | null) => void;
}

const SexoSelect: React.FC<{ sexo: string; onChange: (value: string) => void }> = ({ sexo, onChange }) => {
    return (
        <div className="mb-3">
            <label htmlFor="sexo" className="form-label">
                Sexo
            </label>
            <select
                id="sexo"
                className="form-select"
                value={sexo}
                onChange={(e) => onChange(e.target.value)}
            >
                <option value="" disabled hidden>
                    Seleccione una opción
                </option>
                <option value="Femenino">Femenino</option>
                <option value="Masculino">Masculino</option>
            </select>
        </div>
    );
};

const FechaNacimientoPicker: React.FC<FechaNacimientoPickerProps> = ({ startDate, onChange }) => {
    const datePickerRef = useRef<DatePicker>(null);

    const focusDatePicker = () => {
        if (datePickerRef.current) {
            datePickerRef.current.setFocus();
        }
    };

    // Establecemos una fecha por defecto dentro del rango si startDate es null o no es válida
    const effectiveDate = startDate && isValid(startDate) && startDate >= new Date("1990-01-01") && startDate <= new Date("2005-12-31")
        ? startDate
        : new Date("1995-01-01");

    return (
        <div className="mb-3 d-flex align-items-center">
            <label htmlFor="fechaNacimiento" className="form-label">
                Fecha de Nacimiento
            </label>
            <div className="input-group">
                <DatePicker
                    id="fechaNacimiento"
                    selected={effectiveDate}
                    onChange={onChange}
                    showYearDropdown
                    scrollableYearDropdown
                    yearDropdownItemNumber={15}
                    showMonthDropdown
                    dateFormat="dd/MM/yyyy"
                    maxDate={new Date("2005-12-31")}
                    minDate={new Date("1990-01-01")}
                    className="form-control"
                    ref={datePickerRef}
                    placeholderText="dd/mm/aaaa"
                    useShortMonthInDropdown
                    popperClassName="datepicker-popper-custom" // Usar solo esta línea
                    dropdownMode="select" // Mejor mantener en 'select' y controlar scroll via CSS
                />
                <span className="input-group-text" style={{ cursor: 'pointer' }} onClick={focusDatePicker}>
                    <FontAwesomeIcon icon={faCalendarAlt} />
                </span>
            </div>
        </div>
    );
};

const UniversidadCarreraSelect: React.FC<{ universidad: string; carrera: string; onChangeUniversidad: (value: string) => void; onChangeCarrera: (value: string) => void }> = ({ universidad, carrera, onChangeUniversidad, onChangeCarrera }) => {
    return (
        <>
            <div className="mb-3">
                <label htmlFor="universidad" className="form-label">
                    Universidad
                </label>
                <select
                    id="universidad"
                    className="form-select"
                    value={universidad}
                    onChange={(e) => {
                        const selectedUniversidad = e.target.value;
                        onChangeUniversidad(selectedUniversidad);
                        onChangeCarrera('');
                    }}
                >
                    <option value="" disabled hidden>
                        Seleccione una opción
                    </option>
                    {universidades.map((universidad) => (
                        <option key={universidad.value} value={universidad.value}>{universidad.label}</option>
                    ))}
                </select>
            </div>

            <div className="mb-3">
                <label htmlFor="carrera" className="form-label">
                    Carrera
                </label>
                <select
                    id="carrera"
                    className="form-select"
                    value={carrera}
                    onChange={(e) => onChangeCarrera(e.target.value)}
                    disabled={!universidad}
                >
                    <option value="" disabled hidden>
                        Seleccione una opción
                    </option>
                    {carrerasPorUniversidad[universidad as keyof typeof carrerasPorUniversidad]?.map((carrera) => (
                        <option key={carrera.value} value={carrera.value}>{carrera.label}</option>
                    ))}
                </select>
            </div>
        </>
    );
};

export { SexoSelect, FechaNacimientoPicker, UniversidadCarreraSelect };