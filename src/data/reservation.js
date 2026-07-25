const listingIndex = Number.parseInt(
  process.env.TEST_LISTING_INDEX || '0',
  10
);

const guests = Number.parseInt(
  process.env.TEST_GUESTS || '1',
  10
);

if (
  !Number.isInteger(listingIndex) ||
  listingIndex < 0
) {
  throw new Error(
    'TEST_LISTING_INDEX doit être un entier supérieur ou égal à zéro.'
  );
}

if (
  !Number.isInteger(guests) ||
  guests <= 0
) {
  throw new Error(
    'TEST_GUESTS doit être un entier strictement positif.'
  );
}

const reservationData = {
  listingIndex,
  guests,
  minimumStayDays: 2,
};

module.exports = {
  reservationData,
};