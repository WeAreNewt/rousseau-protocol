import { useProposalData } from '../hooks'

interface ProposalProps {
  id: string
}

const ProposalInfo: React.FC<ProposalProps> = ({ id }) => {
  const { proposal } = useProposalData();
  
  return (
    <div className="flex flex-col items-start w-full ml-48">
      <div>
        <p className="flex flex-row">
          <div>proposal by {' '}</div>
          <a
            href="https://etherscan.io/address/0x14306f86629e6bc885375a1f81611a4208316b2b"
            target="_blank"
            rel="noreferrer"
            className="text-0500FC"
          >
            {' '}
            <a href={`https://polygonscan.com/address/{proposal.owner}`} target="blank">{proposal.owner}</a>
          </a>
        </p>
        <p className="flex flex-row text-gray-800">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
          eiusmod
        </p>
      </div>
      <div className="mt-16">
        <p className="flex flex-row text-black">original </p>
        <p className="flex flex-row text-gray-800">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
          eiusmod
        </p>
      </div>

      <div className="flex flex-row items-center gap-52 mt-16">
        <div className="flex flex-col">
          <p className="text-black">voting starts</p>
          <p className="text-gray-800">Jul 31, 2022, 11:00 AM</p>
        </div>

        <div className="flex flex-col">
          <p className="leading-6 font-medium">voting ends</p>
          <p className="text-gray-800">Aug 7, 2022, 11:00 AM</p>
        </div>
      </div>
    </div>
  )
}

export default ProposalInfo
