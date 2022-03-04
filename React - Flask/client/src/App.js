import React, { useState, useEffect } from "react";

function App() {

  const [data, setData] = useState([{}]);

  useEffect(() => {
    /* fetch("/category/1").then( *//* Use this line for get id */
    fetch("/category").then( /* Use this line for get all */
      res => res.json()
    ).then(
      data => {
        setData(data)
        console.log(data)
      }
    )
  }, [])
  return (
    <div>

      {/* This block is for get by id */}
      {/* {(typeof data.cat_id === 'undefined') ? (
        <p>Loading...</p>
      ) : (
        <div>
              <label >Name of the appliance: {data.cat_nom}<br></br></label>
              <label >description: {data.cat_desp}</label>
        </div>
      )} */}
      {/* End block get by id */}

      {/* This block is for get all */}
      {(typeof data.results === 'undefined') ? (
        <p>Loading...</p>
      ) : (
        data.results.map((value, i) => (
          <div key={i}>
            <label>Name of the appliance: {value["cat_id"]}<br></br></label>
            <label>Name of the appliance: {value["cat_nom"]}<br></br></label>
            <label >description: {value["cat_desp"]}</label><hr></hr>
          </div>
        ))
        )}
        {/* End block get all */}
        
        </div>
  );
}

export default App;
