import { useValueData } from '../hooks'
import Router from 'next/router'

const ValueTable: React.FC = () => {
  const { values } = useValueData()

  return (
    <div className="flex flex-col items-center justify-center w-2/3">
      <table className=" mt-4 w-full border-spacing-x-5">
        <thead>
          <tr>
            <th className="w-[100px] text-left p-3">no.</th>
            <th className="text-left p-3">value</th>
            <th className="w-60 p-3" />
          </tr>
        </thead>
        <tbody>
          {values.map((value) => (
            <tr
              key={`proposal_${value.id}`}
              className=" hover:bg-gray-800 hover:text-white group"
            >
              <td className="group-hover:text-red p-3  text-gray-800 group-hover:text-white">
                {value.id}
              </td>
              <td className="p-3 text-gray-800 group-hover:text-white">
                {value.value}
              </td>
              <td className="p-3">
                <button
                  onClick={() => Router.push('proposal/' + value.id)}
                  className="bg-gray-600 text-white rounded-full w-56 h-10 self-stretch flex-grow invisible group-hover:visible"
                  type="button"
                >
                  propose change
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      <button
        className="flex flex-row justify-center items-center bg-gray-600 text-white rounded-full w-56 h-10 mt-4"
        type="button"
      >
        add value
      </button>
    </div>
  )
}

export default ValueTable
