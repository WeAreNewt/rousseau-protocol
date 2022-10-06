import { NextComponentType } from 'next'
import { useRouter } from 'next/router'
import Header from '../../components/Header'
import ProposalInfo from '../../components/ProposalInfo'

const Proposal: NextComponentType = () => {
  const router = useRouter()
  const { pid } = router.query

  return (
    <div className="flex flex-col items-center relative p-0">
      <Header />
      <ProposalInfo id={Number(pid)} />
    </div>
  )
}

export default Proposal
