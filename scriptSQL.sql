DROP DATABASE IF EXISTS Films;
CREATE DATABASE Films;
USE Films;

DROP TABLE IF EXISTS Actores_en_Peliculas;
DROP TABLE IF EXISTS Actores;
DROP TABLE IF EXISTS Peliculas;

CREATE TABLE Peliculas (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    duracion INT NOT NULL,
    director VARCHAR(100) NOT NULL,
    imagen VARCHAR(200) NULL,
    sinopsis VARCHAR(500) NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Actores (
    id INT NOT NULL,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    nacimiento DATE NULL,
    imagen VARCHAR(200) NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Actores_en_Peliculas (
    idRelacion INT NOT NULL,
    idPelicula INT NOT NULL,
    idActor INT NOT NULL,
    FOREIGN KEY (idPelicula) REFERENCES Peliculas(id),
    FOREIGN KEY (idActor) REFERENCES Actores(id),
    PRIMARY KEY (idPelicula, idActor)
);

DROP PROCEDURE IF EXISTS ListarPeliculas;
DELIMITER $$
CREATE PROCEDURE ListarPeliculas()
BEGIN
    SELECT id, nombre, 
           CONCAT(duracion, 
                  CASE WHEN duracion = 1 THEN ' minuto' ELSE ' minutos' END
           ) AS duracion,
           director, imagen, sinopsis
    FROM Peliculas;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS ObtenerPelicula;
DELIMITER $$
CREATE PROCEDURE ObtenerPelicula(IN pIdPelicula INT)
BEGIN
    SELECT p.id AS idPelicula, p.nombre AS nombrePelicula, 
           CONCAT(p.duracion, 
                  CASE WHEN p.duracion = 1 THEN ' minuto' ELSE ' minutos' END
           ) AS duracion,
           p.director, p.imagen, p.sinopsis,
           a.id AS idActor, a.nombres AS nombresActor, a.apellidos AS apellidosActor
    FROM Peliculas p
    INNER JOIN Actores_en_Peliculas a_p ON a_p.idPelicula = pIdPelicula
    INNER JOIN Actores a ON a_p.idActor = a.id
    WHERE p.id = pIdPelicula
    ORDER BY a_p.idRelacion;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS ActoresEnPelicula;
DELIMITER $$
CREATE PROCEDURE ActoresEnPelicula(IN idPelicula INT)
BEGIN
    SELECT      a_p.idRelacion, p.nombre, a.id, a.nombres, a.apellidos, a.nacimiento, a.imagen
    FROM        Peliculas p
    INNER JOIN  Actores_en_Peliculas a_p ON a_p.idPelicula = idPelicula
    INNER JOIN  Actores a ON a_p.idActor = a.id
    WHERE p.id = idPelicula
    ORDER BY a_p.idRelacion;
END$$
DELIMITER ;

-- Inserción de películas
INSERT INTO Peliculas (nombre, duracion, director, imagen, sinopsis) VALUES ('Pursuit of Happiness', 117, 'Gabriele Muccino', 'pursuit_of_happiness.jpg', 'Chris Gradner es un hombre que, decidido a dar una vida mejor a su familia, inicia un negocio que no acaba bien. Chris se queda en paro, su mujer le abandona y le quitan la casa. Este padre soltero tendrá que luchar por una vida mejor para su hijo.');
INSERT INTO Peliculas (nombre, duracion, director, imagen, sinopsis) VALUES ('Hacksaw Ridge', 139, 'Mel Gibson', 'hacksaw_ridge.png', 'Esta es la historia de Desmond T. Doss, un hombre contrario a la violencia que combatió como médico en la Segunda Guerra Mundial sin portar un arma. No disparó ni una bala, pero salvó a 75 personas de la muerte en la batalla de la isla de Okinawa. Gracias a su coraje, pasó de ser el objeto de las burlas de sus compañeros a ser reconocido por su enorme valía con la entrega de la Medalla de Honor del Congreso, otorgada por primera vez a un objetor de conciencia.');
INSERT INTO Peliculas (nombre, duracion, director, imagen, sinopsis) VALUES ('Gran Torino', 116, 'Clint Eastwood', 'gran_torino.jpg', 'Walt Kowalski, un veterano de la guerra de Corea, es un obrero jubilado del sector del automóvil que ha enviudado recientemente. Su máxima pasión es cuidar de su más preciado tesoro: un coche Gran Torino de 1972. Es un hombre inflexible y cascarrabias, al que le cuesta trabajo asimilar los cambios que se producen a su alrededor, especialmente la llegada de multitud de inmigrantes asiáticos a su barrio. Sin embargo, las circustancias harán que se vea obligado a replantearse sus ideas.');
INSERT INTO Peliculas (nombre, duracion, director, imagen, sinopsis) VALUES ('The Godfather', 177, 'Francis Ford Coppola', 'the_godfather.jpg', 'Don Vito Corleone es el respetado y temido jefe de una de las cinco familias de la mafia de Nueva York en los años 40. El hombre tiene cuatro hijos: Connie, Sonny, Fredo y Michael, que no quiere saber nada de los negocios sucios de su padre. Cuando otro capo, Sollozzo, intenta asesinar a Corleone, empieza una cruenta lucha entre los distintos clanes.');
INSERT INTO Peliculas (nombre, duracion, director, imagen, sinopsis) VALUES ('Click', 108, 'Frank Coraci', 'click.jpg', 'Michael Newman es un arquitecto muy ocupado que intenta progresar en el trabajo y al mismo tiempo tener tiempo para su mujer Donna y sus dos hijos. Un día, después de buscar sin éxito el mando de la televisión, decide comprar uno nuevo. Sin embargo, descubre que el nuevo mando no solo controla los aparatos electrónicos sino que también controla toda su vida. Rápidamente, Michael se vuelve adicto a este poder.');
INSERT INTO Peliculas (nombre, duracion, director, imagen, sinopsis) VALUES ('The Irishman', 209, 'Martin Scorsese', 'the_irishman.jpg', 'Frank Sheeran, veterano de la Segunda Guerra Mundial, estafador y asesino a sueldo recuerda su participación en el asesinato de Jimmy Hoffa. Uno de los grandes misterios sin resolver del país: la desaparición del legendario sindicalista Jimmy Hoffa. Un gran viaje por los turbios entresijos del crimen organizado: sus mecanismos internos, rivalidades y su conexión con la política.');
INSERT INTO Peliculas (nombre, duracion, director, imagen, sinopsis) VALUES ('Inglorious Basterds', 153, 'Quentin Tarantino', 'inglorious_basterds.jpg', 'II Guerra Mundial, Francia, Shosanna presencia la ejecución de su familia por orden del coronel nazi Hans Landa. Huye a Paris y adopta una nueva identidad como propietaria de un cine. Mientras el teniente Aldo Raine adiestra a un grupo de soldados judíos. Los hombres de Raine y una actriz alemana que agente doble, deben llevar a cabo una misión que hará caer a los jefes del Tercer Reich. El destino quiere que todos se encuentren bajo la marquesina de un cine donde Shosanna espera para vengarse.');

INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (1, 'Willard Carroll', 'Smith',                           '1968-09-25', 'will_smith.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (2, 'Jaden Christopher Syre', 'Smith',                    '1998-07-08', 'jaden_smith.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (3, 'Brian', 'Howe',                                      '1953-07-22', 'brian_howe.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (4, 'Melanie Thandiwe', 'Newton',                         '1972-11-06', 'thandie_newton.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (5, 'Daniel Louis', 'Castellanata',                       '1957-10-29', 'dan_castellanata.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (6, 'James', 'Karen',                                     '1923-11-28', 'james_karen.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (7, 'Kurt', 'Fuller',                                     '1953-10-16', 'kurt_fuller.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (8, 'Takayo', 'Fischer',                                  '1932-11-25', 'takayo_fischer.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (9, 'Mark Christopher', 'Lawrence',                       '1964-05-22', 'christopher_lawrence.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (10, 'Christopher Paul', 'Gardner',                       '1954-02-09', 'chris_gardner.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (11, 'Andrew Russell', 'Garfield',                        '1983-08-20', 'andrew_garfield.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (12, 'Samuel Henry John', 'Worthington',                  '1976-08-02', 'sam_worthington.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (13, 'Luke', 'Bracey',                                    '1989-04-26', 'luke_bracey.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (14, 'Hugo Wallace', 'Weaving',                           '1960-04-04', 'hugo_weaving.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (15, 'Teresa Mary', 'Palmer',                             '1986-02-26', 'teresa_palmer.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (16, 'Rachel Anne', 'Griffiths',                          '1968-12-18', 'rachel_griffiths.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (17, 'Vincent Anthony', 'Vaughn',                         '1970-03-28', 'vince_vaughn.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (18, 'Ryan', 'Corr',                                      '1989-01-15', 'ryan_corr.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (19, 'Richard', 'Roxburgh',                               '1962-01-23', 'richard_roxburgh.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (20, 'Luke', 'Pegler',                                    '1981-06-17', 'luke_pegler.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (21, 'Richard', 'Pyros',                                  '1986-04-07', 'richard_pyros.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (22, 'Ben', 'Mingay',                                     '1979-08-09', 'ben_mingay.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (23, 'Michael', 'Sheasby',                                '1979-05-10', 'michael_sheasby.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (24, 'Firass', 'Dirani',                                  '1984-04-29', 'firass_dirani.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (25, 'Damien', 'Thomlinson',                              '1982-09-21', 'damien_thomlinson.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (26, 'Matthew', 'Nable',                                  '1972-03-08', 'matthew_nable.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (27, 'Ben', 'O''Toole',                                   '1991-07-10', 'ben_otoole.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (28, 'Nathaniel', 'Buzolic',                              '1989-08-04', 'nathaniel_buzolic.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (29, 'Milo', 'Gibson',                                    '1990-11-16', 'milo_gibson.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (30, 'Goran D.', 'Kleut',                                 '1975-11-04', 'goran_kleut.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (31, 'Clinton', 'Eastwood',                               '1930-05-31', 'clint_eastwood.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (32, 'Bee', 'Vang',                                       '1991-11-04', 'bee_vang.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (33, 'Whitney Cua', 'Her',                                '1992-07-13', 'ahney_her.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (34, 'Christopher Murphy', 'Carley',                      '1978-05-31', 'chris_carley.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (35, 'Doua', 'Moua',                                      '1987-02-07', 'doua_moua.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (36, 'Sonny', 'Vue',                                      '1984-03-27', 'sonny_vue.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (37, 'Elvis', 'Thao',                                     '1972-07-27', 'elvis_thao.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (160, 'Brian', 'Haley',                                   '1963-02-12', 'brian_haley.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (38, 'Geraldine', 'Hughes',                               '1970-01-01', 'geraldine_hughes.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (39, 'Dreama Elyse', 'Walker',                            '1986-06-20', 'dreama_walker.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (40, 'Michael E.', 'Kurowski',                            NULL,         'michael_kurowski.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (41, 'John Carroll', 'Lynch',                             '1963-08-01', 'john_lynch.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (42, 'Chee', 'Thao',                                      '1952-06-05', 'chee_thao.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (43, 'Scott', 'Eastwood',                                 '1986-03-21', 'scott_eastwood.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (44, 'Marlon', 'Brando',                                  '1924-04-03', 'marlon_brando.png');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (45, 'Alfredo James', 'Pacino',                           '1940-04-25', 'al_pacino.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (46, 'James Edmund', 'Caan',                              '1940-03-26', 'james_caan.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (47, 'Richard Salvatore', 'Castellano',                   '1933-09-04', 'richard_castellano.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (48, 'Robert Selden', 'Duvall',                           '1931-01-05', 'robert_duvall.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (49, 'Sterling Walter', 'Hayden',                         '1916-03-26', 'sterling_hayden.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (50, 'John', 'Marley',                                    '1907-10-17', 'john_marley.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (51, 'Nicholas Peter', 'Conte',                           '1910-03-14', 'richard_conte.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (52, 'Alfredo', 'Lettieri',                               '1928-02-24', 'al_lettieri.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (53, 'Diane', 'Keaton',                                   '1946-01-05', 'diane_keaton.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (54, 'Abraham Charles', 'Vigoda',                         '1921-02-24', 'abe_vigoda.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (55, 'Talia Rose', 'Shire',                               '1946-04-25', 'talia_shire.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (56, 'Gianni Vito', 'Russo',                              '1943-12-12', 'gianni_russo.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (57, 'John Holland', 'Cazale',                            '1935-08-12', 'john_cazale.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (58, 'Rudolph', 'Bond',                                   '1912-10-10', 'rudy_bond.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (59, 'Al', 'Martino',                                     '1927-10-07', 'al_martino.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (60, 'Maria Grazia Morgana', 'Messina',                   '1930-06-04', 'morgana_king.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (61, 'Lenny', 'Montana',                                  '1926-03-13', 'lenny_montana.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (62, 'Johnny', 'Martino',                                 '1937-05-05', 'john_martino.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (63, 'Salvatore', 'Corsitto',                             '1913-01-09', 'salvatore_corsitto.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (64, 'Richard James', 'Bright',                           '1937-06-28', 'richard_bright.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (65, 'Alex', 'Rocco',                                     '1936-02-29', 'alex_rocco.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (66, 'Joseph Anthony', 'Giorgio',                         '1923-09-27', 'tony_giorgio.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (67, 'Vito Giusto', 'Scozzari',                           '1918-01-26', 'vito_scotti.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (68, 'Tere', 'Livrano',                                   NULL,         'tere_livrano.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (69, 'Victor', 'Rendina',                                 '1916-12-28', 'victor_rendina.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (70, 'Jeannie', 'Linero',                                 '1945-08-28', 'jeannie_linero.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (71, 'Julie', 'Gregg',                                    '1937-01-24', 'julie_gregg.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (72, 'Ardell', 'Sheridan',                                '1943-08-05', 'ardell_sheridan.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (73, 'Adam Richard', 'Sandler',                           '1943-08-05', 'adam_sandler.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (74, 'Kathrin Romany', 'Beckinsale',                      '1973-07-26', 'kate_beckinsale.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (75, 'Christopher', 'Walken',                             '1943-03-31', 'chris_walken.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (76, 'David Michael', 'Hasselhoff',                       '1952-07-17', 'david_hasselhoff.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (77, 'Henry Franklin', 'Winkler',                         '1945-10-30', 'henry_winkler.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (78, 'Julie Deborah', 'Kavner',                           '1950-09-07', 'julie_kavner.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (79, 'Sean Patrick', 'Astin',                             '1971-02-25', 'sean_astin.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (80, 'Sally', 'Insul',                                    '1916-10-03', 'sally_insul.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (81, 'Joseph Michael', 'Castanon',                        '1997-08-23', 'joseph_castanon.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (82, 'Danielle Tatum', 'McCann',                          '1999-03-25', 'tatum_maccann.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (83, 'Cameron Riley', 'Monaghan',                         '1993-08-16', 'cameron_monaghan.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (84, 'Jennifer', 'Coolidge',                              '1961-08-28', 'jennifer_coolidge.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (85, 'Rachel Susan', 'Dratch',                            '1966-02-22', 'rachel_dratch.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (86, 'Sophie Charlene Akland', 'Monk',                    '1979-12-14', 'sophie_monk.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (87, 'Michelle Helen', 'Lombardo',                        '1983-09-16', 'michelle_lombardo.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (88, 'Jana Rae', 'Kramer',                                '1983-12-02', 'jana_kramer.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (89, 'Nicholas Roger', 'Swardson',                        '1976-10-09', 'nick_swardson.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (90, 'Frank', 'Coraci',                                   '1966-02-03', 'frank_coraci.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (91, 'Robert Michael', 'Schneider',                       '1963-10-31', 'rob_schneider.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (92, 'James Earl', 'Jones',                               '1931-01-17', 'james_jones.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (93, 'Terry Alan', 'Crews',                               '1968-07-30', 'terry_crews.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (94, 'Dolores Mary Eileen', 'O''Riordan',                 '1971-09-06', 'dolores_oriordan.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (95, 'Robert Anthony', 'De Niro',                         '1943-08-17', 'de_niro.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (96, 'Joseph Frank', 'Pesci',                             '1943-02-09', 'joe_pesci.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (97, 'Raymond Albert', 'Romano',                          '1957-12-21', 'ray_romano.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (98, 'Bobby', 'Cannavale',                                '1970-05-03', 'bobby_cannavale.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (99, 'Anna Hélène', 'Paquin',                             '1982-07-24', 'anna_paquin.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (100,'Stephen Joseph', 'Graham',                          '1973-08-03', 'stephen_graham.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (101, 'Harvey', 'Keitel',                                 '1939-05-13', 'harvey_keitel.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (102, 'Stephanie', 'Kurtzuba',                            '1972-03-20', 'stephanie_kurtzuba.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (103, 'Kathrine', 'Narducci',                             '1965-11-22', 'kathrine_narducci.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (104, 'Welker', 'White',                                  '1964-09-01', 'welker_white.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (105, 'Jesse', 'Plemons',                                 '1988-04-02', 'jesse_plemons.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (106, 'Jack Alexander', 'Huston',                         '1982-12-07', 'jack_huston.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (107, 'Domenick', 'Lombardozzi',                          '1976-03-25', 'domenick_lombardozzi.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (108, 'Paul', 'Herman',                                   '1946-03-29', 'paul_herman.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (109, 'Louis', 'Cancelmi',                                '1978-06-09', 'louis_cancelmi.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (110, 'Rebecca', 'Faulkenberry',                          NULL,         'rebecca_faulkenberry.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (111, 'Gary', 'Basaraba',                                 '1959-03-16', 'gary_basaraba.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (112, 'Marin Yvonne', 'Ireland',                          '1979-08-30', 'marin_ireland.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (113, 'Sebastian', 'Maniscalco',                          '1973-07-08', 'sebastian_maniscalco.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (114, 'Steven', 'Van Zandt',                              '1950-11-22', 'steven_van_zandt.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (115, 'Jennifer', 'Mudge',                                '1978-08-16', 'jennifer_mudge.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (116, 'Tony', 'Suriano',                                  NULL,         'tony_suriano.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (117, 'William Bradley', 'Pitt',                          '1963-12-18', 'brad_pitt.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (118, 'Mélanie', 'Laurent',                               '1983-02-21', 'melanie_laurent.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (119, 'Christoph', 'Waltz',                               '1956-10-04', 'christoph_waltz.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (120, 'Eli Raphael', 'Roth',                              '1972-04-18', 'eli_roth.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (121, 'Michael', 'Fassbender',                            '1977-04-02', 'mike_fassbender.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (122, 'Diane', 'Kruger',                                  '1976-07-15', 'diane_kruger.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (123, 'Daniel César Martín', 'Brühl González Domingo',    '1978-06-16', 'daniel_gonzalez.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (124, 'Tilman Valentin', 'Schweiger',                     '1963-12-19', 'til_schweiger.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (125, 'Benjamin Joseph Manaly', 'Novak',                  '1979-07-31', 'benjamin_novak.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (126, 'Gedeon', 'Burkhard',                               '1969-07-03', 'gedeon_burkhard.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (127, 'Jacky', 'Ido',                                     '1977-05-14', 'jacky_ido.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (128, 'Omar', 'Doom',                                     '1976-06-29', 'omar_doom.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (129, 'Samuel Franklin', 'Levine',                        '1982-03-12', 'samuel_levine.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (130, 'August', 'Diehl',                                  '1976-01-04', 'august_diehl.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (131, 'Denis', 'Ménochet',                                '1976-09-18', 'denis_menochet.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (132, 'Sylvester', 'Groth',                               '1958-03-31', 'sylvester_groth.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (133, 'Martin', 'Wuttke',                                 '1962-02-08', 'martin_wuttke.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (134, 'Michael John', 'Myers',                            '1963-05-25', 'mike_myers.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (135, 'Julie', 'Dreyfus',                                 '1966-01-24', 'julie_dreyfus.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (136, 'Richard', 'Sammel',                                '1960-10-13', 'richard_sammel.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (137, 'Alexander', 'Fehling',                             '1981-03-29', 'alexander_fehling.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (138, 'Rodney Sturt', 'Taylor',                           '1930-01-11', 'rodney_taylor.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (139, 'Sönke', 'Möhring',                                 '1972-10-12', 'sonke_mohring.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (140, 'Paul Robert', 'Rust',                              '1981-04-12', 'paul_rust.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (141, 'Michael', 'Bacall',                                '1973-04-19', 'mike_bacall.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (142, 'Carlos', 'Fidel',                                  NULL,         'carlos_fidel.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (143, 'Ken', 'Duken',                                     '1979-04-17', 'ken_duken.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (144, 'Christian', 'Berkel',                              '1957-10-28', 'chris_berkel.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (145, 'Anne-Sophie', 'Franck',                            '1986-04-12', 'anne_franck.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (146, 'Léa Hélène', 'Seydoux-Fornierde Clausonne',        '1985-07-01', 'lea_seydoux.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (147, 'Tina', 'Rodríguez',                                '1982-09-24', 'tina_rodriguez.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (148, 'Lena', 'Friedrich',                                NULL,         'lena_friedrich.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (149, 'Jana', 'Pallaske',                                 '1979-05-20', 'jana_pallaske.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (150, 'Rainer', 'Bock',                                   '1954-07-31', 'rainer_bock.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (151, 'Michael', 'Scheel',                                '1962-03-24', 'michael_scheel.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (152, 'Buddy Joe', 'Hooker',                              '1942-05-30', 'buddy_hooker.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (153, 'Christian', 'Brückner',                            '1943-10-17', 'chris_bruckner.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (154, 'Hilmar', 'Eichhorn',                               '1954-08-18', 'hilmar_eichhorn.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (155, 'Patrick', 'Elias',                                 '1966-04-09', 'patrick_elias.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (156, 'Eva', 'Löbau',                                     '1972-04-26', 'eva_lobau.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (157, 'Salvadore', 'Brandt',                              NULL,         'salvadore_brandt.jpg');
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (158, 'Jasper', 'Linnewedel',                             NULL, NULL);
INSERT INTO Actores(id, nombres, apellidos, nacimiento, imagen) VALUES (159, 'Volker Zack', 'Michalowski',                       '1971-01-31', 'volker_michalowski.jpg');

INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (1, 1, 1);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (2, 1, 2);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (3, 1, 3);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (4, 1, 4);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (5, 1, 5);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (6, 1, 6);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (7, 1, 7);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (8, 1, 8);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (9, 1, 9);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (10, 1, 10);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (11, 2, 11);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (12, 2, 12);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (13, 2, 13);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (14, 2, 14);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (15, 2, 15);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (16, 2, 16);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (17, 2, 17);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (18, 2, 18);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (19, 2, 19);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (20, 2, 20);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (21, 2, 21);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (22, 2, 22);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (23, 2, 23);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (24, 2, 24);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (25, 2, 25);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (26, 2, 26);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (27, 2, 27);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (28, 2, 28);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (29, 2, 29);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (30, 2, 30);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (31, 3, 31);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (32, 3, 32);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (33, 3, 33);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (34, 3, 34);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (35, 3, 35);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (36, 3, 36);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (37, 3, 37);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (38, 3, 38);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (39, 3, 160);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (40, 3, 3);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (41, 3, 39);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (42, 3, 40);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (43, 3, 41);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (44, 3, 42);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (45, 3, 43);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (46, 4, 44);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (47, 4, 45);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (48, 4, 46);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (49, 4, 47);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (50, 4, 48);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (51, 4, 49);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (52, 4, 50);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (53, 4, 51);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (54, 4, 52);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (55, 4, 53);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (56, 4, 54);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (57, 4, 55);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (58, 4, 56);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (59, 4, 57);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (60, 4, 58);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (61, 4, 59);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (62, 4, 60);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (63, 4, 61);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (64, 4, 62);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (65, 4, 63);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (66, 4, 64);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (67, 4, 65);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (68, 4, 66);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (69, 4, 67);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (70, 4, 68);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (71, 4, 69);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (72, 4, 70);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (73, 4, 71);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (74, 4, 72);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (75, 5, 73);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (76, 5, 74);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (77, 5, 75);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (78, 5, 76);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (79, 5, 77);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (80, 5, 78);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (81, 5, 79);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (82, 5, 80);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (83, 5, 81);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (84, 5, 82);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (85, 5, 83);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (86, 5, 84);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (87, 5, 85);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (88, 5, 86);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (89, 5, 87);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (90, 5, 88);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (91, 5, 89);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (92, 5, 90);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (93, 5, 91);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (94, 5, 92);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (95, 5, 93);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (96, 5, 94);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (97, 6, 95);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (98, 6, 96);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (99, 6, 97);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (100, 6, 98);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (101, 6, 99);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (102, 6, 100);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (103, 6, 101);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (104, 6, 102);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (105, 6, 103);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (106, 6, 104);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (107, 6, 105);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (108, 6, 106);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (109, 6, 107);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (110, 6, 108);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (111, 6, 109);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (112, 6, 110);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (113, 6, 111);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (114, 6, 112);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (115, 6, 113);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (116, 6, 114);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (117, 6, 115);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (118, 6, 116);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (119, 7, 117);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (120, 7, 118);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (121, 7, 119);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (122, 7, 120);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (123, 7, 121);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (124, 7, 122);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (125, 7, 123);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (126, 7, 124);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (127, 7, 125);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (128, 7, 126);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (129, 7, 127);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (130, 7, 128);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (131, 7, 129);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (132, 7, 130);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (133, 7, 131);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (134, 7, 132);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (135, 7, 133);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (136, 7, 134);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (137, 7, 135);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (138, 7, 136);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (139, 7, 137);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (140, 7, 138);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (141, 7, 139);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (142, 7, 140);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (143, 7, 141);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (144, 7, 142);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (145, 7, 143);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (146, 7, 144);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (147, 7, 145);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (148, 7, 146);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (149, 7, 147);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (150, 7, 148);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (151, 7, 149);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (152, 7, 150);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (153, 7, 151);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (154, 7, 152);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (155, 7, 153);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (156, 7, 154);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (157, 7, 155);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (158, 7, 156);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (159, 7, 157);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (160, 7, 158);
INSERT INTO Actores_en_Peliculas(idRelacion, idPelicula, idActor) VALUES (161, 7, 159);
