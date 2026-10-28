import Explorer from "@/components/Explorer";
import { getAnalogs } from "@/lib/nasa";

export default async function Home() {
  return <Explorer analogs={await getAnalogs()} />;
}
