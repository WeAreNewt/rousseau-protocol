import { NextComponentType } from 'next'
import { useProposalData } from '../hooks'

interface ProposalProps {
  id: string
}

const ProposalInfo: NextComponentType = ({ id }: any) => {
  const { proposal } = useProposalData()

  return (
    <div className="flex flex-col items-start w-full ml-2/3">
      <div>
        <p className="flex flex-row">
          proposal by{' '}
          <a
            href="https://etherscan.io/address/0x14306f86629e6bc885375a1f81611a4208316b2b"
            target="_blank"
            rel="noreferrer"
          >
            {' '}
            {proposal.owner}
          </a>
        </p>
        <p className="flex flex-row">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
          eiusmod
        </p>
      </div>
      <div className="mt-16">
        <p className="flex flex-row">original </p>
        <p className="flex flex-row">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
          eiusmod
        </p>
      </div>

      <div className="flex flex-row">
        <div className="flex flex-col">
          <p>voting starts</p>
          <p>uwu</p>
        </div>

        <div className="flex flex-col">
          <p>voting end</p>
          <p>uwu</p>
        </div>
      </div>
    </div>
  )
}

export default ProposalInfo
