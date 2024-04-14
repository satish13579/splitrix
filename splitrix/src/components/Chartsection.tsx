// import { PieChart } from 'react-minimal-pie-chart';
import DonutChart from 'react-donut-chart';
import '../assets/styles/Home.css'

const Chartsection = () => {
  return (
    <>
    <div className="chart_section_com">
        <div className="split_data">
            <p>Total Splits :-  23</p>
            <p>Groups Participated :-  6</p>
            <p>Amount Splitted :-  10,000rs</p>
            <p>Rewards Received Worth :-  15rs</p>
        </div>
        <DonutChart
            data={[
                {
                label: 'Rent',
                value: 20,
                },
                {
                label: 'Miscelleneous',
                value: 40,
                },
                {
                    label: 'Travel',
                    value: 10,
                    },
                    {
                    label: 'Loan',
                    value: 20,
                    },
                    {
                        label: 'Invest',
                        value: 10,
                        },
            ]}
            className='donut_chart_style'/>;
    </div>
    </>
  )
}

export default Chartsection