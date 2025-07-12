"use client"; // Components are server components by default, Add this line to enable client-side rendering

import Link from "next/link";
import { useRouter } from "next/navigation";

export default function Home() {
  const router = useRouter()

  function captchaCallback(response: string) {
    Print.postMessage(response);
  }

  function testCallback(response: string) {
    Test.postMessage(response);
  }

  function nextCallback(response: string) {
    Next.postMessage(response);
    router.push('/dashboard')
  }

  function pageCallback(response: string) {
    Page.postMessage(response);
  }

  return (
    <div className="grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">
      <button onClick={() => pageCallback("name")}>
        Page
      </button>
      <button onClick={() => nextCallback("Change to page B")}>
        Next
      </button>
      <button onClick={() => testCallback("Test....")}>
        Test
      </button>
      <Link href="/dashboard">Dashboard</Link>
    </div>
  );
}
