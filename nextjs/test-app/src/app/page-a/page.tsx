"use client"; // Add this line to enable client-side rendering

export default function Home() {
  function testCallback(response: string) {
    Test.postMessage(response);
  }

  return (
    <div className="grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">
      Dashboard
      <button onClick={() => testCallback("CCCCC")}>
        Test
      </button>
    </div>
  );
}
