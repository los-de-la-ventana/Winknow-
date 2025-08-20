-- ==============================================
-- inno db es para las claves foraneas en mySql
-- on update y on delete cascadea es para q se borre toda la cascada de registros 
--si se borra un usuario q se borre adm , docentes y los otros tipos de usuarios
-- ==============================================

CREATE TABLE Usuarios (
    Cedula INT PRIMARY KEY,
    Contrasenia VARCHAR(50),
    Nombre_usr VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE Email (
    Cedula INT NOT NULL,
    numeroTelefono VARCHAR(50),
    email VARCHAR(50),
    FOREIGN KEY (Cedula) REFERENCES Usuarios(Cedula)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Docente (
    codigo_doc INT PRIMARY KEY AUTO_INCREMENT,
    Cedula INT NOT NULL,
    grado INT,
    IdReserva INT,
    contrasenia VARCHAR(100),
    AnioInsercion DATE,
    Estado VARCHAR(20),
    FOREIGN KEY (Cedula) REFERENCES Usuarios(Cedula)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Administrador (
    codigo_adm INT PRIMARY KEY AUTO_INCREMENT,
    Cedula INT NOT NULL,
    EsAdmin BOOLEAN,
    rolAdmin VARCHAR(100),
    FOREIGN KEY (Cedula) REFERENCES Usuarios(Cedula)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Estudiante (
    Cedula INT NOT NULL,
    FechaNac DATE,
    FOREIGN KEY (Cedula) REFERENCES Usuarios(Cedula)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Cursos
CREATE TABLE Cursos (
    IdCurso INT PRIMARY KEY AUTO_INCREMENT,
    Cedula INT NOT NULL, -- responsable/docente
    Recursos_Pedidos VARCHAR(100),
    Orientacion VARCHAR(50),
    FOREIGN KEY (Cedula) REFERENCES Docente(Cedula)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;
-- Relación: Docente dicta Cursos
CREATE TABLE Dictan (
    Cedula INT NOT NULL,
    IdCurso INT NOT NULL,
    PRIMARY KEY (Cedula, IdCurso),
    FOREIGN KEY (Cedula) REFERENCES Docente(Cedula)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Relación: Estudiante inscripto en Curso
CREATE TABLE Estudiante_Curso (
    Cedula INT NOT NULL,
    IdCurso INT NOT NULL,
    PRIMARY KEY (Cedula, IdCurso),
    FOREIGN KEY (Cedula) REFERENCES Estudiante(Cedula)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Horario
CREATE TABLE Horario (
    ID_horario INT PRIMARY KEY AUTO_INCREMENT,
    Hora TIME,
    Dia DATE,
    IdCurso INT NOT NULL,
    Cedula INT NOT NULL,
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Cedula) REFERENCES Docente(Cedula)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Secundario
CREATE TABLE Secundario (
    IdCurso INT NOT NULL,
    anio INT,
    PRIMARY KEY (IdCurso),
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Terciario
CREATE TABLE Terciario (
    IdCurso INT NOT NULL,
    NumSemestres INT,
    PRIMARY KEY (IdCurso),
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Espacios (aulas, salones, etc.)
CREATE TABLE Espacios (
    IdEspacio INT PRIMARY KEY AUTO_INCREMENT,
    NumEdificio INT,
    NumSalon INT,
    capacidad INT,
    Estado_Espacio VARCHAR(20),
    Tipo_salon VARCHAR(30)
) ENGINE=InnoDB;

-- Recursos (materiales, equipos)
CREATE TABLE Recursos (
    IdRecurso INT PRIMARY KEY AUTO_INCREMENT,
    nombre_Recurso VARCHAR(120),
    IdEspacio INT NOT NULL,
    FOREIGN KEY (IdEspacio) REFERENCES Espacios(IdEspacio)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Reserva de espacio con recurso
CREATE TABLE Reserva (
    IdReserva INT PRIMARY KEY AUTO_INCREMENT,
    IdEspacio INT NOT NULL,
    Fecha DATE,
    Hora_Reserva INT,
    FOREIGN KEY (IdEspacio) REFERENCES Espacios(IdEspacio)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Relación: Docente solicita recurso
CREATE TABLE Docente_Recurso (
    IdRecurso INT NOT NULL,
    Cedula INT NOT NULL,
    PRIMARY KEY (IdRecurso, Cedula),
    FOREIGN KEY (IdRecurso) REFERENCES Recursos(IdRecurso)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Cedula) REFERENCES Docente(Cedula)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Asignaturas
CREATE TABLE Asignatura (
    IdAsignatura INT PRIMARY KEY AUTO_INCREMENT,
    nombreAsignatura VARCHAR(50)
) ENGINE=InnoDB;

-- Relación: Asignatura en un curso
CREATE TABLE Asignatura_Curso (
    IdAsignatura INT NOT NULL,
    IdCurso INT NOT NULL,
    PRIMARY KEY (IdAsignatura, IdCurso),
    FOREIGN KEY (IdAsignatura) REFERENCES Asignatura(IdAsignatura)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;
