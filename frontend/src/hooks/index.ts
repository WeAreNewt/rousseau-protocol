interface ValueData {
  id: number
  value: string
}

interface ProposalData {
  owner: string
  value: string
  kind: number
  start: number
  end: number
}

const values: ValueData[] = [
  {
    id: 1,
    value:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
  },
  {
    id: 2,
    value:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
  },
  {
    id: 3,
    value:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
  },
  {
    id: 4,
    value:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
  },
]

const proposal: ProposalData = {
  owner: 'josepbove.eth',
  value: 'This is a value',
  kind: 0, // 0 = add, 1 = remove, 2 = replace
  start: 1663075830,
  end: 1663075830,
}

// this hook should do the async call for the proposals data
export const useValueData = () => {
  return { values: values }
}

export const useProposalData = () => {
  return { proposal: proposal }
}
