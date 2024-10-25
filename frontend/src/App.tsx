import React from 'react';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import Login from './pages/login-register/login-page';
import Registro from './pages/login-register/register-page';
import Home from './pages/user/home-page'
import UsuarioPage from './pages/user/user-page';
import TestPage from './pages/user/test-page';
import ResultadoPage from './pages/user/result-page';
import AdminHomePage from './pages/administrator/home-admin-page';
import { AuthProvider } from './services/auth-service'; 
import '@fortawesome/fontawesome-free/css/all.css';
import LoginAdmin from './pages/administrator/login-administrador-page';
import DetalleAdmin from './pages/administrator/detalle-admin-page';
import AnsiedadPage from './pages/user/ansiedad-page';
import SpinPage from './pages/user/spin-page';


function App() {

  return (
    <AuthProvider>
      <BrowserRouter>
        <div className="App">
          <Routes>
            <Route path="/" element={<Login />} />
            <Route path="/register-page" element={<Registro />} />
            <Route path="/home" element={<Home />} />
            <Route path="/ansiedad-social" element={<AnsiedadPage />} />
            <Route path="/login-admin" element={<LoginAdmin />} />
            <Route path="/admin-page" element={<AdminHomePage />} />
            <Route path="/detalle/:idPersona" element={<DetalleAdmin />} />
            <Route path="/test-page" element={<TestPage />} />
            <Route path="/result-page" element={<ResultadoPage />} />
            <Route path="/user-page" element={<UsuarioPage />} />
            <Route path="/spin-page" element={<SpinPage />} />
          </Routes>
        </div>
      </BrowserRouter>
    </AuthProvider>
  );
}

export default App;