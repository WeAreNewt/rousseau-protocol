# Rousseau Protocol

Rousseau Protocol is a ‘social contract’ protocol where members of an organization can propose, vote, and align on values that are stored as text on chain.

For example, Avara Labs can vote on whether 'one release at a time' is a valid value and product strategy for the entire team.

In another example, DAOs can vote and agree on their Code of Conduct, which can be timelocked and revised after a certain amount of time has elapsed.

## How It Works

Rousseau Protocol is available first as an implementation that is specifically tailored to the needs of Avara Labs. However, Rousseau Protocol is modular and generalizable, meaning that other organizations can add their custom logic as 'modules' in order to leverage the power of Rousseau Protocol's contracts and on-chain voting capability.

### Contracts

The Protocol consists of a base contract (RousseauGovernance) and three interfaces (IRousseauEligibilty, IRousseauQuorum, IRousseauStorage) that allow for any arbitrary logic to be deployed in order to use the base contract.

IRousseauEligibilty determines the eligibility criteria of who is able to vote on values and value proposals within Rousseau Protocol. For Avara Labs, we're using nontransferrable NFTs that team members own in their respective Polygon addresses.

IRousseauQuorum determines the rules for governance and what threshold needs to be crossed in order for a value proposal to 'pass'.

IRousseauRepository determines where the values will be stored -- whether on-chain (in the contract or on Lens Protocol) or stored off-chain (IPFS, Arweave, etc).

### Front End
Rousseau Protocol will have a voting frontend to allow for users to determine if their eligible to vote with a specific organization, vote for values on-chain, and propose revisions, additions, or removal of values.
