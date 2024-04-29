'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "ae7da3a791489f25e90f1f0717a54792",
"index.html": "31e5c2821dee2b916d345b4217017c36",
"/": "31e5c2821dee2b916d345b4217017c36",
"main.dart.js": "d1932944dd437f7531a1ff64ff44d518",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "00b940bb79aade491b4938b98e8ab1fd",
"assets/AssetManifest.json": "37165b06a4a43bbebfd169903c4e5686",
"assets/NOTICES": "38f94cf4dba3bdc170f8d5b9c34260e2",
"assets/FontManifest.json": "88735d266268008347ae3ac22f0aef90",
"assets/AssetManifest.bin.json": "f38f0f02ca63164a733bb84985439b53",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "b6fda070b44c9ed9c80a0465741ed36a",
"assets/fonts/MaterialIcons-Regular.otf": "80e2885e0bce6cfaba9852220bcfc922",
"assets/assets/images/types/ghost.svg": "ff3973459922626c46b8935bd3517deb",
"assets/assets/images/types/rock.svg": "499a0fa10362807e9a3218082be3d288",
"assets/assets/images/types/fairy.svg": "603e08d1937f16395d2d304ef6d30ab7",
"assets/assets/images/types/electric.svg": "68b142da814c55f9225db2c16193ba01",
"assets/assets/images/types/dragon.svg": "18a1dbc9e3a69ba77e890268451026e4",
"assets/assets/images/types/fire.svg": "33d14b307cd671ab9c1ca76f4788df7a",
"assets/assets/images/types/dark.svg": "b7d4f57872507c79b1ecd192aad61357",
"assets/assets/images/types/steel.svg": "95342da3d89b3644b12d596a41d631c7",
"assets/assets/images/types/fighting.svg": "8ce4fa81f8f29f8c6871b88f78916637",
"assets/assets/images/types/bug.svg": "14540979a6685ab378bf0cee1e97f942",
"assets/assets/images/types/psychic.svg": "60982f05e13fbd9b6e6d96ce3456d365",
"assets/assets/images/types/normal.svg": "8f2a7aaa9ae7bd49980f1b2b99a2577f",
"assets/assets/images/types/ground.svg": "289c4927e264d15f5be41d5c53f5c601",
"assets/assets/images/types/water.svg": "e29fb8e379f9ed5335a02eb3881d25d6",
"assets/assets/images/types/ice.svg": "f82b7e5d85efb43a4e5001ed490269d4",
"assets/assets/images/types/grass.svg": "d589dd00e175efada7294faf05f52ac6",
"assets/assets/images/types/flying.svg": "8c1e094fa4fa86cf9a4b943d6b6c9253",
"assets/assets/images/types/poison.svg": "183135e96caba5df8c380e0d2acdea6a",
"assets/assets/images/sad.png": "f8cc25d7275e11caf098ee83e66c558f",
"assets/assets/images/footprints/88.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/77.png": "bf62ab5ff65324c97a9e07dadd28b135",
"assets/assets/images/footprints/63.png": "082782292f79ca3c498337a5d7861395",
"assets/assets/images/footprints/62.png": "0de8f3a2e6cf3733a8286b7744e4f88f",
"assets/assets/images/footprints/76.png": "d336e0f017cc3b2ebb387d00c0037ba0",
"assets/assets/images/footprints/89.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/149.png": "ba0b5ee1e8cbad102202cd9c04f76502",
"assets/assets/images/footprints/60.png": "b3d93518b82087fc522e02bc13ccd53b",
"assets/assets/images/footprints/74.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/48.png": "220b9b62ad5cf0318b7669d16abd45d8",
"assets/assets/images/footprints/49.png": "1d1e18ecd8f96622bd25acc643bc66d9",
"assets/assets/images/footprints/75.png": "88f3322721c79b32380d74740f0eb362",
"assets/assets/images/footprints/61.png": "06f43177786044da1d9a94e1dac7c465",
"assets/assets/images/footprints/148.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/59.png": "473e43300f86916e965a3abe081a79e6",
"assets/assets/images/footprints/65.png": "b05aa6e9a9449ddd0d07909b879a6d0e",
"assets/assets/images/footprints/71.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/70.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/64.png": "fc370f4ff4a6f648c396b7511e96a9ef",
"assets/assets/images/footprints/58.png": "95bf2c401379b69662c7e7b17f66db30",
"assets/assets/images/footprints/99.png": "d36fb6e0f63977c253bcda681ac5a7c6",
"assets/assets/images/footprints/8.png": "005bd1cefacebe0d6ccd1725ae9e03f1",
"assets/assets/images/footprints/72.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/66.png": "2b085fbdfcd939705c7a23052774affa",
"assets/assets/images/footprints/67.png": "6745681725cdcca73ebdf3d99b3c72da",
"assets/assets/images/footprints/73.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/9.png": "c2291650508e1bdc9edde58e08b71fb6",
"assets/assets/images/footprints/98.png": "57555bab81bc2659d4dc1c81547fe28b",
"assets/assets/images/footprints/129.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/115.png": "d2497be95b331f570d7cd37632eb4bea",
"assets/assets/images/footprints/101.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/14.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/28.png": "74167672828f96cb413adb8d492c6969",
"assets/assets/images/footprints/29.png": "72a64c3a12764c0e4bc6229e698cfb43",
"assets/assets/images/footprints/15.png": "4f561a93c71d24f3fe5a3c9d187c834b",
"assets/assets/images/footprints/100.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/114.png": "00ab6efc546df85e134ab13ab064e05e",
"assets/assets/images/footprints/128.png": "001113f812f2b0a55d4b9b0e000e1271",
"assets/assets/images/footprints/102.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/116.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/17.png": "1e8f288320fa7af8ffbafbd32e6fdf8f",
"assets/assets/images/footprints/16.png": "6cf3604d3cc41ead94ee04f39341acd2",
"assets/assets/images/footprints/117.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/103.png": "0b88c717548678f62772e6afc5330ea4",
"assets/assets/images/footprints/107.png": "f2253af87cea02b216ae2e960f48899e",
"assets/assets/images/footprints/113.png": "f0b7f1658cf5c539c6d57794a1dc04ef",
"assets/assets/images/footprints/12.png": "6019c84f3269f40ac486405086b01f53",
"assets/assets/images/footprints/13.png": "7ce37207412053e1d2b6547aee65baf4",
"assets/assets/images/footprints/112.png": "f5d323cb762da95de68e568e86659918",
"assets/assets/images/footprints/106.png": "da6ea9144a9ae1713331bf0f0be9387f",
"assets/assets/images/footprints/110.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/104.png": "77653345740c90904267069ae340db1c",
"assets/assets/images/footprints/138.png": "6c9df10a4c7d001bf879ddb714f6bd67",
"assets/assets/images/footprints/39.png": "90d60936b6060609987365874260d9ef",
"assets/assets/images/footprints/11.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/10.png": "7ce37207412053e1d2b6547aee65baf4",
"assets/assets/images/footprints/38.png": "f41b2c21d2a0b8966f79f6f54674dc9b",
"assets/assets/images/footprints/139.png": "72d8e12d5d06d7f1825918f2fadd64c3",
"assets/assets/images/footprints/105.png": "cdca0f23e24fc3b0de172c6b45275a66",
"assets/assets/images/footprints/111.png": "052d3c468916f07e1a442257740a94c0",
"assets/assets/images/footprints/108.png": "8d615e1b33cfe3caee24e66866b233fd",
"assets/assets/images/footprints/134.png": "dae113a87a44b6827bfd300184df4e27",
"assets/assets/images/footprints/120.png": "7ce37207412053e1d2b6547aee65baf4",
"assets/assets/images/footprints/35.png": "852fb2dd787c19d89f5aa89a44567da8",
"assets/assets/images/footprints/21.png": "6cf3604d3cc41ead94ee04f39341acd2",
"assets/assets/images/footprints/20.png": "316ba97cdeaba65891205f5e2317dc3e",
"assets/assets/images/footprints/34.png": "9ded4bcf8f6339e3e80aea5f5f519c62",
"assets/assets/images/footprints/121.png": "7ce37207412053e1d2b6547aee65baf4",
"assets/assets/images/footprints/135.png": "46f0c390698f944e1f755d177a716c8e",
"assets/assets/images/footprints/109.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/123.png": "0f00233967da71ec924fccca8715f2b8",
"assets/assets/images/footprints/137.png": "41bde018b6615e88b67546ef691a0558",
"assets/assets/images/footprints/22.png": "6cc122f70052de1fd842945d92dd9817",
"assets/assets/images/footprints/36.png": "2840dc5d65f67301dd0a2628841284b7",
"assets/assets/images/footprints/37.png": "73fb490e72e2dde63622d89692b00d90",
"assets/assets/images/footprints/23.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/136.png": "a99c54f628692df4990066499e119bcc",
"assets/assets/images/footprints/122.png": "4fd9f4dd7b0d61195533cc33ab35cd6d",
"assets/assets/images/footprints/126.png": "36d2c803c83786c99f9271b22349fbfa",
"assets/assets/images/footprints/132.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/27.png": "b8d0bae098d4c7864829df46c525e7b2",
"assets/assets/images/footprints/33.png": "43e8480557f8df4130741a8337d8de02",
"assets/assets/images/footprints/32.png": "b98e1b207627d9ce32e3216eb5de0bb4",
"assets/assets/images/footprints/26.png": "7ce841fc8f3fa14efa5aa9403f62a19f",
"assets/assets/images/footprints/133.png": "6d8819ccb346d2fc88694ee7f73bd5b5",
"assets/assets/images/footprints/127.png": "cd4735190dd26c9f69be000e3609826a",
"assets/assets/images/footprints/131.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/125.png": "d0d4921e5791de652c238a8c6aaac441",
"assets/assets/images/footprints/119.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/18.png": "687e6b90acbf283d2db041ee79a029ff",
"assets/assets/images/footprints/30.png": "ea09a347f2c0659b779100c1fcdfa648",
"assets/assets/images/footprints/24.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/25.png": "84b09e5ca554b8f9136fc3a6a124bc65",
"assets/assets/images/footprints/31.png": "306815c5864f5deb130491445e8a2b26",
"assets/assets/images/footprints/19.png": "3d59635b244d7f01d8d7999883f3d0dd",
"assets/assets/images/footprints/118.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/124.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/130.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/95.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/81.png": "6ed31363e6b12399b3941248e9e23c23",
"assets/assets/images/footprints/143.png": "3a2fa5219ad509e345d2bdbc768f9efe",
"assets/assets/images/footprints/4.png": "fc3dbede041e6dfb2bc4f7dda7c2a609",
"assets/assets/images/footprints/56.png": "82c188475b30c4c42260f7aaa18c2a0e",
"assets/assets/images/footprints/42.png": "ba249351257f06f328b1fcedced7ad28",
"assets/assets/images/footprints/43.png": "07d8ba44c8b87d827be082c8550fa13c",
"assets/assets/images/footprints/5.png": "1a5a06cd4a436e35d418931002b741c8",
"assets/assets/images/footprints/57.png": "e138502aacf5259361bbec0a67b2b7c1",
"assets/assets/images/footprints/142.png": "de0239496ba3e7b1402c63410ed20330",
"assets/assets/images/footprints/156.png": "99b0cd14f87e79c8ec45f2789b2e026d",
"assets/assets/images/footprints/80.png": "a385bcf674067682b6a5e801443a4295",
"assets/assets/images/footprints/94.png": "192b88c48f93dbf418eca32d1fa7a31f",
"assets/assets/images/footprints/82.png": "700f19a65990251e58f2a74cd455f1b6",
"assets/assets/images/footprints/96.png": "919ee3090e5a65db4138e40312824794",
"assets/assets/images/footprints/140.png": "1d1e18ecd8f96622bd25acc643bc66d9",
"assets/assets/images/footprints/154.png": "d5cd2f9a8482d182bca9fe14f120a85d",
"assets/assets/images/footprints/41.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/55.png": "78be024f49fe0fd8562017bff8694873",
"assets/assets/images/footprints/7.png": "0a968284b208d9b6cbc42db079d44dae",
"assets/assets/images/footprints/69.png": "f01ab2d26e34212eec789c34cfeddf6c",
"assets/assets/images/footprints/68.png": "3597d8f227926926f85fc024de93cd37",
"assets/assets/images/footprints/54.png": "559e1f29dfff7ab0480ff99ee674374f",
"assets/assets/images/footprints/6.png": "12ff411b10d795f19c66c13609aaa8eb",
"assets/assets/images/footprints/40.png": "d1ab8ad5099ae66e7209b1c1b8c12da0",
"assets/assets/images/footprints/155.png": "30f94c20827b7d0461d38e4c7ac26d4f",
"assets/assets/images/footprints/141.png": "cb446ffdd6a0232641ac686a1b76289a",
"assets/assets/images/footprints/97.png": "14e88dfa5721f95cc2a1fdbdce770af3",
"assets/assets/images/footprints/83.png": "0a81f1c4d86f4064c4c69a2922b5cb25",
"assets/assets/images/footprints/145.png": "428650e630e273b2511e56d9b3c0d964",
"assets/assets/images/footprints/151.png": "58708858b9b50c28f0e05169bdfed7b7",
"assets/assets/images/footprints/87.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/93.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/78.png": "16cbfdd3f38ed2a67751012b1162a7f9",
"assets/assets/images/footprints/44.png": "cdba96f9c38ccef0bcb85c4acacb2822",
"assets/assets/images/footprints/2.png": "961826f377b2dd7302fd3d86cb0e45f1",
"assets/assets/images/footprints/50.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/3.png": "f7696834ff16869d05b91d7a620660cd",
"assets/assets/images/footprints/51.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/45.png": "a754217f992b2d5253e7d79bfcacd0da",
"assets/assets/images/footprints/79.png": "310b918a8a9e9809c8d526b9ec8f7d21",
"assets/assets/images/footprints/92.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/86.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/150.png": "133b4c32c91f914aa33385db9589664d",
"assets/assets/images/footprints/144.png": "114c1831f9241bbc5532f53ecf4be324",
"assets/assets/images/footprints/152.png": "a9e40167929c6b015721f719428a67eb",
"assets/assets/images/footprints/146.png": "f52d9a0633a6edfb8c6d0885cd0e8c1d",
"assets/assets/images/footprints/90.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/84.png": "b22adf1bb7e0bd941710a979152012db",
"assets/assets/images/footprints/53.png": "f553695731ddc633bc59ff42124c4af4",
"assets/assets/images/footprints/1.png": "28e7bb001687a703e9cb9c4cd5c7bf0e",
"assets/assets/images/footprints/47.png": "3e79a95db289c590e91037621a6535bb",
"assets/assets/images/footprints/46.png": "79f8e0b634f4350862e146ea9653f146",
"assets/assets/images/footprints/52.png": "0639c5d82a74b0897266cc2c29ec90a1",
"assets/assets/images/footprints/85.png": "100c4c6ea46762d9ae6f092e5820d5a4",
"assets/assets/images/footprints/91.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/147.png": "5470230cf7e9e8ae7d4efb1793a3efa8",
"assets/assets/images/footprints/153.png": "cc1c1b0e4f48be19f6047ff3f6dc0f4e",
"assets/assets/images/pokeball.png": "edd72be48d41170cc2ee61a6c8f46657",
"assets/assets/images/oak_2.webp": "f945742087c2f7d251cad7e5d4106f0d",
"assets/assets/images/oak.png": "c16dbe65e6d8c03d82a6374c972d2e2e",
"assets/assets/images/devest.svg": "eaa40dfd890b889d550bb6d90ca69a94",
"assets/assets/images/pokeball.svg": "5c4f7f0ce891d03c2cb3a74434ee3537",
"assets/assets/fonts/Pokemon/PokemonHollow.ttf": "6e5393a64ca23c455e8568d409e82da6",
"assets/assets/fonts/Pokemon/PokemonSolid.ttf": "36d26dbcd032a9d91d891c9f22dfdec6",
"assets/assets/fonts/Corben/Corben-Bold.ttf": "3356ad538d5048fb57cd2663e5aed02d",
"assets/assets/fonts/Corben/Corben-Regular.ttf": "310f8577a5db0267fdfeef3b60360254",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
