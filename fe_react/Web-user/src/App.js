import Layout from "./components/Layout/Layout";
import {AppProvider} from './context';
function App() {
  return (
    <AppProvider>
      <Layout />
    </AppProvider>
  );
}

export default App;
