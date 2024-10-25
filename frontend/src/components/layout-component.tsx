// Layout.tsx
import React, { ReactNode } from 'react';
import Navbar from './navbar-component';
import { useNavigate } from 'react-router-dom';
import '../styles/estilo.css'

interface LayoutProps {
    user: any;
    handleLogout: () => void;
    children: ReactNode;
    title: string;
    subtitle?: string;

    titleClassName?: string;
    subtitleClassName?: string;
}

const Layout: React.FC<LayoutProps> = ({ user,
    handleLogout,
    title,
    subtitle,
    titleClassName,
    subtitleClassName,
    children }) => {

    const navigate = useNavigate();

    const handleLogoutAndRedirect = () => {
        handleLogout();
        navigate('/');
    };

    return (
        <>
            <Navbar user={user} handleLogout={handleLogoutAndRedirect} />
            <div className="layout-container">
                <div className="color-principal div_principal" >
                    <div className="row justify-content-center align-items-center">
                        <div className="col-lg-9">
                            <div className="card-body-desktop">
                                {title && <h1 className={`mere_title mb-4 center ${titleClassName}`}>{title}</h1>}
                                {subtitle && <p className={`mere_p mb-2 ${subtitleClassName}`}>{subtitle}</p>}
                                {children}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
};

export default Layout;
