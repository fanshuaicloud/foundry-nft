//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {BasicNft} from "../src/BasicNft.sol";
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public expectedTokenUri =
        "ipfs://Qmc33sjPLbVLVEcnPhsuYBPboz9K63NJi4ty7XMGWNnQaa/?filename=SHABA.json";

        string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";


    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PUG_URI);
        vm.stopBroadcast();
    }
}
