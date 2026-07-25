const traveler = {
  username: process.env.TRAVELER_USERNAME?.trim() || '',
  password: process.env.TRAVELER_PASSWORD || '',
};

const host = {
  username: process.env.HOST_USERNAME?.trim() || '',
  password: process.env.HOST_PASSWORD || '',
};

const invalidUser = {
  username: 'utilisateur-inexistant@example.test',
  password: 'mot-de-passe-invalide',
};

module.exports = { traveler, host, invalidUser };
