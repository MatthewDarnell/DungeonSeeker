const { expect } = require("chai");
const hre = require("hardhat");
const {
  loadFixture,
  time,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");

describe("GM", function () {
  async function deployContract() {
    const _gm = await hre.ethers.getContractFactory("GM");
    const gm = await _gm.deploy();
    return { gm };
  }

    it("Should Create A Campaign And Roll A Skill Check and Report Results", async function () {
      const { gm } = await loadFixture(deployContract);
      await gm.createCampaign(1, 2);
      const campaign = await gm.getCampaign(1);
      const c = await hre.ethers.getContractAt("CampaignState", campaign);
      await c.addPlayer('0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', "Player1");
      await c.setPartyPlayerStats('0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', "Player1", 1, 1, 1, 1, 1, 1, 1, 1, 1);
      const retrievedStats = await c.getPlayerStats('0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', "Player1");
      const retVal = await gm.skillCheck(1, 100, '0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', 'Player1', 'INT', 20, 10);
      //TODO: Get Event from retVal with Result
  });

  it("Should Roll an Items' Damage", async function () {
    const { gm } = await loadFixture(deployContract);
    await gm.createCampaign(1, 2);
    const campaign = await gm.getCampaign(1);
    const c = await hre.ethers.getContractAt("CampaignState", campaign);
    await c.addPlayer('0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', "Player1");
    await c.setPartyPlayerStats('0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', "Player1", 1, 1, 1, 1, 1, 1, 1, 1, 1);
    const retrievedStats = await c.getPlayerStats('0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', "Player1");
    //(uint campaignId, uint itemId, address playerAddress, string memory name, string memory itemType, uint stats) public {

    const numDice = 2;
    const dieSize = 8;
    const sign = 1;
    const bonus = 1;
    let stats = 0;
    stats |= numDice & 0xFF;
    stats <<= 8;
    stats |= dieSize & 0xFF;
    stats <<= 8;
    stats |= sign & 0xFF;
    stats <<= 8;
    stats |= bonus & 0xFF;
    await gm.addItemToPlayerInventory(1, 24, '0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', 'Longsword', 'WEAPON', stats);
    const atkRoll = await gm.itemRoll(1, 100, '0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', 24);
    //TODO: Get Event from atkRoll with Result
  });
});