import Explorer from "@/components/Explorer";
import { getData } from "@/lib/data";

export default async function Home() {
  const { analogs, sites } = await getData();
  return <Explorer analogs={analogs} sites={sites} />;
}
