const prodHost = 'http://105.235.30.236:888/';
const devHost = 'http://192.168.8.154:888/';
const host = prodHost;

const apiService = host + 'listServices';
const apiMachines = host + 'listMachines';
const apiConnexion = host + 'listUsers/search/byUserConnexiont';
const apiTestEmail = host + 'listUsers/search/byUser';
const apiCreateUser = host + 'listUsers';
const apiSaveReservation = host + 'listPlaces';
const apiReservationByEmail = host + 'listPlaces/search/byUser';
const apiReservationById = host + 'listPlaces/';
const apiReservationByCoord = host + 'listPlaces/search/coordonnees';