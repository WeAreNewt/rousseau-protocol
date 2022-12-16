// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

import "forge-std/Script.sol";
import "../src/core/base/RousseauProtocol.sol";
import "../src/core/modules/RousseauRepository.sol";
import "../src/core/modules/RousseauEligibility.sol";
import "../src/core/modules/RousseauQuorum.sol";
import "../src/mocks/AvaraNFT.sol";

contract Deploy is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        AvaraNFT avaraNFT = new AvaraNFT("AvaraNFT", "AVARA");

        RousseauEligibility eligibility = new RousseauEligibility(
            address(avaraNFT)
        );

        uint256 votePeriod = 86400;
        uint256 voteDelay = 86400;
        uint256 quorumPercentage = 50;
        RousseauQuorum quorum = new RousseauQuorum(
            votePeriod,
            voteDelay,
            address(avaraNFT),
            quorumPercentage
        );

        RousseauRepository repository = new RousseauRepository();

        RousseauProtocol protocol = new RousseauProtocol(
            address(repository),
            address(eligibility),
            address(quorum)
        );

        repository.initialize(address(protocol));

        vm.stopBroadcast();
    }
}
