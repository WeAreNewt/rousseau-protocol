import { AddModal } from "../components/modals/AddModal"
import { ChangeModal } from "../components/modals/ChangeModal";
import type { NextPage } from 'next'

const Home: NextPage = () => {
  return (
    <div className="flex flex-col justify-center items-center">
      <div className="mb-[300px]">testing</div>
      <ChangeModal />
    </div>
  )
}

export default Home
