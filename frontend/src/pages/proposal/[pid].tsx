import { useRouter } from 'next/router'
import type { NextPage } from 'next'
import Header from '../../components/Header'
import ProposalInfo from '../../components/ProposalInfo'

const Proposal: NextPage = () => {
  const router = useRouter()
  const { pid } = router.query

  return (
    <div className="flex flex-col items-center relative p-0">
      <Header />
      <ProposalInfo id={String(pid)!}/>
    </div>
  )
}

export default Proposal
