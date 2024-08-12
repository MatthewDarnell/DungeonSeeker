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
    await campaign.setPartyPlayerStats('0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', "Player1", 1, 1, 1, 1, 1, 1, 1, 1, 1);
    let retrievedStats = await campaign.getPlayerStats('0xbDA5747bFD65F08deb54cb465eB87D40e51B197E', "Player1");
    expect(retrievedStats).to.be.equal(18519084246547628289n);

  
    let stat = parseInt(retrievedStats >> 64n) & 0xFF;
    expect(stat).to.be.equal(1);
    stat = parseInt(retrievedStats >> 56n) & 0xFF;
    expect(stat).to.be.equal(1);
    stat = parseInt(retrievedStats >> 48n) & 0xFF;
    expect(stat).to.be.equal(1);
    stat = parseInt(retrievedStats >> 40n) & 0xFF;
    expect(stat).to.be.equal(1);
    stat = parseInt(retrievedStats >> 32n) & 0xFF;
    console.log(stat)
    expect(stat).to.be.equal(1);
    let lower = parseInt(retrievedStats & 0xFFFFFFFFn);
    stat = (lower >> 24) & 0xFF;
    expect(stat).to.be.equal(1);
    stat = (lower >> 16) & 0xFF;
    expect(stat).to.be.equal(1);
    stat = (lower >> 8) & 0xFF;
    expect(stat).to.be.equal(1);
    stat = lower & 0xFF;
    expect(stat).to.be.equal(1);
  });
});