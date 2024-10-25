import { useAuth } from '../../services/auth-service';
import '../../components/layout-component'
import Layout from '../../components/layout-component';
import '../../styles/estilo.css'

const AnsiedadPage: React.FC = () => {
  const { user, logout } = useAuth();
  return (
    <Layout 
      user={user} handleLogout={logout} 
      title='Ansiedad Social o Fobia Social'
      subtitle='Es un trastorno mental que se caracteriza por un miedo intenso e irracional ante situaciones sociales o actividades que involucran la interacción con otras personas.'
      titleClassName="vlad_result_title"
      subtitleClassName="vlad_result_subtitle"
      >
        
      <div className='mb-4 center'>
      <div className="vlad_result_container">
      <div className='question-container'>
      <div className="mere_p">
        <p>Los individuos que padecen este trastorno a menudo sienten un temor persistente a ser juzgados, humillados o avergonzados por los demás, lo que puede llevarlos a evitar contextos sociales o experimentar síntomas tanto físicos cómo psicológicos al enfrentarlos.</p>
      </div>
        <div className='vlad_result_device'>
          <h3>Algunos de los sintomas <br/> son los siguientes:</h3>
        </div>
        <div className='vlad_result_advice'>
            <ul>
                <li>Los síntomas físicos suelen incluir sudoración excesiva, palpitaciones, temblores, enrojecimiento facial, náuseas, dificultades para hablar o tragar, e incluso problemas gastrointestinales como la diarrea.</li>
                <li>A nivel psicológico, a menudo se manifiestan como una preocupación excesiva por lo que otros puedan pensar, sentimientos de vergüenza o humillación, baja autoestima, y la tendencia a evitar situaciones sociales, lo que puede interferir significativamente en la vida diaria.</li>
                <li>En el entorno académico, los estudiantes que enfrentan este trastorno suelen optar por el silencio cuando tienen dudas, evitando así la interacción tanto con los profesores como con sus compañeros. Además, suelen tener un círculo social bastante limitado, lo que puede aumentar su sensación de aislamiento y estrés.</li>
                <li>En el campus universitario las situaciones pueden ser variadas, como la ansiedad al entrar a una sala de clases cuando todos ya están sentados, hablar en público durante presentaciones o debates, ser vistos entrando a un baño, escribir o firmar documentos en presencia de otros, participar en grupos de estudio o proyectos académicos, comer o beber en lugares públicos como el comedor, interactuar con figuras de autoridad, asistir a eventos sociales, e incluso hablar por teléfono en presencia de otras personas.</li>
            </ul>
          </div>
      </div>
      <p>*Si se siente identificado con algunos de estos síntomas, es importante acudir a un profesional del área de psicología para obtener ayuda y orientación adecuada.</p>
    </div>
      </div>
    </Layout>

  );
};

export default AnsiedadPage;
