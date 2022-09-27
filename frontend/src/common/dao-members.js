import { faker } from "@faker-js/faker";

const NUMBER_OF_MEMBERS = 42;

export default generateMembers();

function generateMembers() {
  const members = [];
  for (let i = 0; i < NUMBER_OF_MEMBERS; i++) {
    members.push(generateNewMember(i));
  }
  return members;
}

function generateNewMember() {
  const randomNumber = Math.round(Math.random() * 10000);
  return {
    name: faker.internet.userName(),
    img: faker.image.avatar(),
    address: `0x${randomNumber}C359e...3CFE${randomNumber}`,
    balance: randomNumber,
  };
}
