import { useAuth } from '../../services/auth-service';
import '../../components/layout-component'
import Layout from '../../components/layout-component';
import '../../styles/estilo.css'

const SpinPage: React.FC = () => {
    const { user, logout } = useAuth();
    return (
        <Layout
            user={user} handleLogout={logout}
            title='Inventario de Fobia Social'
            subtitle='Social Phobia Inventory, SPIN, 2000'
            titleClassName="vlad_result_title"
            subtitleClassName="vlad_result_subtitle"
        >

            <div className='mb-4 center'>
                <div className="vlad_result_container">
                    <div className='question-container'>
                        <div className="mere_p">
                            <p> El cuestionario consta de 17 ítems, que se puntúan en una escala del 0 al 4, donde se mide la intensidad de la respuesta del usuario. Esta herramienta ha sido ampliamente utilizada en contextos clínicos y de investigación debido a su facilidad de administración, validez y confiabilidad.</p>
                        </div>
                        <div className='vlad_result_device'>
                            <h3>El SPIN cubre tres dimensiones <br /> clave de la ansiedad social: </h3>
                        </div>
                        <div className='vlad_result_advice'>
                            <ul>
                                <li>Miedo a situaciones sociales: Seis ítems se enfocan en medir el temor experimentado ante diferentes situaciones sociales o de interacción.</li>
                                <li>Evitación de situaciones sociales: Siete ítems exploran la tendencia del individuo a evitar situaciones sociales que generan ansiedad.</li>
                                <li>Malestar fisiológico: Cuatro ítems evalúan las manifestaciones físicas del malestar asociado con la ansiedad social, como sudoración, temblores o palpitaciones.</li>
                            </ul>
                        </div>
                    </div>
                    <p>*Aunque el SPIN ayuda a evaluar la ansiedad social, no reemplaza un diagnóstico clínico. Se recomienda consultar a un profesional de la salud mental para un diagnóstico preciso y recomendaciones personalizadas.</p>
                </div>
            </div>
        </Layout>

    );
};

export default SpinPage;
