const { expect } = require("chai");
const hre = require("hardhat");
const {
  loadFixture,
  time,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");

describe("CampaignState", function () {
  async function deployContract() {
    const _campaign = await hre.ethers.getContractFactory("CampaignState");
    const campaign = await _campaign.deploy(1, 2);
    return { campaign };
  }

  it("Should Enforce Max Party Size", async function () {
      const { campaign } = await loadFixture(deployContract);
      const players = ['0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', '0xdD2FD4581271e230360230F9337D5c0430Bf44C0']
      await Promise.all(players.map(async address => {
        return await campaign.addPlayer(address, "player")
      }))
     await expect(campaign.addPlayer("0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199", "player")).to.be.revertedWith("Party Full!");
  });

  it("Should Allow Begin and End Encounters", async function () {
    const { campaign } = await loadFixture(deployContract);
    const players = ['0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', '0xdD2FD4581271e230360230F9337D5c0430Bf44C0']
    await Promise.all(players.map(async address => {
      return await campaign.addPlayer(address, "player")
    }))
    let isInInitiative = await campaign.isInInitiative();
    expect(isInInitiative).to.be.equal(false);
    await campaign.startEncounter();
    isInInitiative = await campaign.isInInitiative();
    expect(isInInitiative).to.be.equal(true);
    await campaign.endEncounter();
    isInInitiative = await campaign.isInInitiative();
    expect(isInInitiative).to.be.equal(false);
  });

  it("Should Set and Retrieve Packed Stats", async function () {
    const { campaign } = await loadFixture(deployContract);
    await campaign.addPlayer('0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', "Player1");
    await campaign.setPartyPlayerStats('0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', "Player1", 1, 1, 1, 1, 1, 1, 1, 1);
    let retrievedStats = await campaign.getPlayerStats('0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', "Player1");
    retrievedStats = parseInt(retrievedStats)
    let stats = [0, 0, 0, 0, 0, 0, 0, 0]
    let index = 56;
    for(let i =0; i < 8; i++) {
      let temp = retrievedStats >> (index);
      console.log(temp);
      stats[i] = parseInt(temp & (0xFF));
      retrievedStats -= 8;
    }
    for(const stat of stats) {
      expect(stat).to.be.equal(1);
    }
});
});