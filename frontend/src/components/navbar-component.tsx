import React from 'react';
import '../styles/estilo.css';
import { useNavigate } from 'react-router-dom';

interface NavbarProps {
  user: any;
  handleLogout: () => void;
}

const Navbar: React.FC<NavbarProps> = ({ user, handleLogout }) => {
  const navigate = useNavigate();
  
  return (
    <nav className="navbar navbar-expand-lg navbar-dark navbar-custom mere_nav">
      <div className="container">
        <button className="btn btn-link text-white order-lg-1" onClick={() => navigate(-1)}>
          <i className="fas fa-arrow-left icon-color"></i>
        </button>
        
        {/* Botón Hamburguesa para móviles */}
        <button 
          className="navbar-toggler order-lg-3" 
          type="button" 
          data-bs-toggle="collapse" 
          data-bs-target="#navbarCollapse" 
          aria-controls="navbarCollapse" 
          aria-expanded="false" 
          aria-label="Toggle navigation"
        >
          <span className="navbar-toggler-icon"></span>
        </button>

        <a className="navbar-brand mere_navbar_color mx-lg-auto order-lg-2" href="/">
          AnxieSense - Sistema Experto
        </a>

        <div className="collapse navbar-collapse order-lg-4" id="navbarCollapse">
          <div className="d-flex flex-column flex-lg-row align-items-start align-items-lg-center w-100">
            <div className="d-flex flex-grow-1 justify-content-center justify-content-lg-start my-2 my-lg-0">
              <a className="nav-link mere_navbar_color me-lg-3" href="/spin-page">
                ¿Qué es el SPIN?
              </a>
              <a className="nav-link mere_navbar_color" href="/ansiedad-social">
                ¿Qué es la Ansiedad Social?
              </a>
            </div>
            
            <div className="d-flex align-items-center ms-lg-auto">
              {user ? (
                <button className="btn btn-link text-white" onClick={handleLogout}>
                  <i className="fas fa-sign-out-alt icon-color"></i>
                </button>
              ) : (
                <button 
                  className="btn btn-link text-white" 
                  onClick={() => navigate('/login')}
                >
                  Iniciar sesión
                </button>
              )}
            </div>
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;