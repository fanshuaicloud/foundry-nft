//SPDX-Lisense-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;
    DeployBasicNft public deployBasicNft;
    address public USER = makeAddr("user");
    string public expectedTokenUri = "ipfs://Qmc33sjPLbVLVEcnPhsuYBPboz9K63NJi4ty7XMGWNnQaa/?filename=SHABA.json";


    function setUp() public {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "BasicNft";
        string memory actualName = basicNft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(expectedTokenUri);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(expectedTokenUri)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
