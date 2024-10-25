// export default Navbar;
// Navbar.tsx

import React from 'react';
import '../styles/estilo.css';
import { useNavigate } from 'react-router-dom';


interface NavbarProps {
  user: any; // Puedes definir el tipo de usuario aquí
  handleLogout: () => void;
}

const Navbar: React.FC<NavbarProps> = ({ user, handleLogout }) => {
  const navigate = useNavigate();
  return (
    <nav className="navbar navbar-expand-lg navbar-dark navbar-custom mere_nav" >
      <div className="container">
        <button className="btn btn-link text-white" onClick={() => navigate(-1)}>
          <i className="fas fa-arrow-left icon-color"></i>
        </button>
        <a className="navbar-brand mere_navbar_color mx-auto" href="/">AnxieSense - Sistema Experto</a>
        <div className="collapse navbar-collapse" id="navbarCollapse">
          <ul className="navbar-nav me-auto mb-2 mb-lg-0"></ul>
          <div className="d-flex align-items-center">
            <a className="navbar-brand mere_navbar_color mx-auto align-items-end me-3" href="/spin-page">¿Qué es el SPIN?</a>
            <a className="navbar-brand mere_navbar_color mx-auto align-items-end" href="/ansiedad-social">¿Qué es la Ansiedad Social?</a>
            {user ? (
              <div className="d-flex align-items-center">
                <button className="btn" onClick={handleLogout}>
                  <i className="fas fa-sign-out-alt icon-color"></i>
                </button>
              </div>
            ) : (
              <p className="mb-0 text-white">No hay usuario autenticado</p>
            )}
          </div>
        </div>
      </div>
    </nav>
  );

};

export default Navbar;
