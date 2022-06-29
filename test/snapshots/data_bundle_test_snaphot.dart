import 'package:arweave/src/models/models.dart';
import 'package:arweave/src/utils.dart';

final testTagsSnapshot = <Tag>[
  Tag(
    encodeStringToBase64('MyTag'),
    encodeStringToBase64('Foo'),
  ),
  Tag(
    encodeStringToBase64('MyTag'),
    encodeStringToBase64('Foo'),
  ),
  Tag(
    encodeStringToBase64('MyTag'),
    encodeStringToBase64('ඒයි මේ @#\$?. ’“[]{}字符'),
  ),
  //1500 characters
  Tag(
    encodeStringToBase64('Long Length Tag'),
    encodeStringToBase64(
        'etokujyhmjzeybeezryyjhnqtqcuxuhisvhiwckjsisgzvnlnyhnsempnnocsboufhiskzgfxtlyvypkm'
        'baahdjntaiqoaludueozsoputqgsttxhjdjmfvmxieecanlhchuungnvjtavuebwtcygqjnmjhjuuzwzw'
        'glmqbsgcnyivdktsbrlvkwgyvuecqyvatutyuxxsyfswmyadagrgazolkjrvzhlwetunwrwrmgiriirznva'
        'vyygizfojifrhsnkfawkgpdffsrjqhwgalhvpwfnpplheakujzxqxbsprsneppqxdpvctwnbbplbwsqluvvw'
        'fxogjxwuyfodjgfwwmaefbszcjfjgifmerzbgxwpmugnewfomzxtrxozcklejwtqikqxsnhzktyjsgmzvohrn'
        'wsrwrwkkmnfmxskpbqmndzaiyjdpwqeqzfpidszavtfhaiegvjtpzvdlbwjbomnrlgiqoybyakvjckgznheqcow'
        'iroaywchrouuxysbqelcxcksbaaqnzpnzunoovexwqtxpwvqqaovnsefaslywjmyzitfxfyhrkbhkiwgztddkbetb'
        'bdloebfbezzovkyjtaypifnkujvfecxyjbajneohtqrqptjnbsvbuarffdignrvrvylttecshkooqrcnebfrmobje'
        'rgfujphamrayqkqehpruskqfvurwhadubxujtqolymrubmjaztmgzjpjkiybgltesantosrqevqxpdgfnnqmswfdqq'
        'drtpptzddzcuuhfqefhucawbqmwbqguujkcgptlvgfbbfrfvxakqffhkyholzgqvhdzuqjlbfmwaucwvhltjvjfreuo'
        'ckfemcutnxhfhyrrhknhlpsqayiybvsosvbjrcvahvbkvcwmlfpccycmmnyqanxlspjgbdufbbnqktdyugczbqhkhfaw'
        'etgohlmwrlfwrzbfmpebkhjbctithrouccnznkcrsnkdawfdylfmoyrlatuslfpremqvyvoweremwcpfjoagek'
        'kuppiyjiozqvtjrgfsjukjvncadcsgmjksoqveqltvlgxzjctnduehaygwlcywccrnrsfziotvpgzmzmscujwmcltx'
        'fsqopysuwlsyumnzkuvzuzqmalhskepvytjzyubvqcnbxqsxvsllrwltjoahsbxztkgohnnkcexuvdapdkdnrmhipen'
        'tmapypkqshtcnsvbklolyromhokxglprkrzkhhwgwzanfbbhgqnhzztasaxjrhltlgahpuwsbqpwlxigzbydeqwbyswxx'
        'gvgwmdxblggyoebuqxjolkbwuktuqyxudcmbxyusabnhscxdgxgesasmhvhknrmitgkslknjisdmgvyimtzdbtwoeqiq'
        'cptghykymjjxloaiwwfewgnkfhztzgjjbvnpxzzbwazvtmkfimwguqecpkufkxuaevgkqgirmnpavcvwrdqzcmqviwcvxlq'),
  )
];

final testTagsBufferSnapshot = [
  8,
  10,
  77,
  121,
  84,
  97,
  103,
  6,
  70,
  111,
  111,
  10,
  77,
  121,
  84,
  97,
  103,
  6,
  70,
  111,
  111,
  10,
  77,
  121,
  84,
  97,
  103,
  78,
  224,
  182,
  146,
  224,
  182,
  186,
  224,
  183,
  146,
  32,
  224,
  182,
  184,
  224,
  183,
  154,
  32,
  64,
  35,
  36,
  63,
  46,
  32,
  226,
  128,
  153,
  226,
  128,
  156,
  91,
  93,
  123,
  125,
  229,
  173,
  151,
  231,
  172,
  166,
  30,
  76,
  111,
  110,
  103,
  32,
  76,
  101,
  110,
  103,
  116,
  104,
  32,
  84,
  97,
  103,
  182,
  23,
  101,
  116,
  111,
  107,
  117,
  106,
  121,
  104,
  109,
  106,
  122,
  101,
  121,
  98,
  101,
  101,
  122,
  114,
  121,
  121,
  106,
  104,
  110,
  113,
  116,
  113,
  99,
  117,
  120,
  117,
  104,
  105,
  115,
  118,
  104,
  105,
  119,
  99,
  107,
  106,
  115,
  105,
  115,
  103,
  122,
  118,
  110,
  108,
  110,
  121,
  104,
  110,
  115,
  101,
  109,
  112,
  110,
  110,
  111,
  99,
  115,
  98,
  111,
  117,
  102,
  104,
  105,
  115,
  107,
  122,
  103,
  102,
  120,
  116,
  108,
  121,
  118,
  121,
  112,
  107,
  109,
  98,
  97,
  97,
  104,
  100,
  106,
  110,
  116,
  97,
  105,
  113,
  111,
  97,
  108,
  117,
  100,
  117,
  101,
  111,
  122,
  115,
  111,
  112,
  117,
  116,
  113,
  103,
  115,
  116,
  116,
  120,
  104,
  106,
  100,
  106,
  109,
  102,
  118,
  109,
  120,
  105,
  101,
  101,
  99,
  97,
  110,
  108,
  104,
  99,
  104,
  117,
  117,
  110,
  103,
  110,
  118,
  106,
  116,
  97,
  118,
  117,
  101,
  98,
  119,
  116,
  99,
  121,
  103,
  113,
  106,
  110,
  109,
  106,
  104,
  106,
  117,
  117,
  122,
  119,
  122,
  119,
  103,
  108,
  109,
  113,
  98,
  115,
  103,
  99,
  110,
  121,
  105,
  118,
  100,
  107,
  116,
  115,
  98,
  114,
  108,
  118,
  107,
  119,
  103,
  121,
  118,
  117,
  101,
  99,
  113,
  121,
  118,
  97,
  116,
  117,
  116,
  121,
  117,
  120,
  120,
  115,
  121,
  102,
  115,
  119,
  109,
  121,
  97,
  100,
  97,
  103,
  114,
  103,
  97,
  122,
  111,
  108,
  107,
  106,
  114,
  118,
  122,
  104,
  108,
  119,
  101,
  116,
  117,
  110,
  119,
  114,
  119,
  114,
  109,
  103,
  105,
  114,
  105,
  105,
  114,
  122,
  110,
  118,
  97,
  118,
  121,
  121,
  103,
  105,
  122,
  102,
  111,
  106,
  105,
  102,
  114,
  104,
  115,
  110,
  107,
  102,
  97,
  119,
  107,
  103,
  112,
  100,
  102,
  102,
  115,
  114,
  106,
  113,
  104,
  119,
  103,
  97,
  108,
  104,
  118,
  112,
  119,
  102,
  110,
  112,
  112,
  108,
  104,
  101,
  97,
  107,
  117,
  106,
  122,
  120,
  113,
  120,
  98,
  115,
  112,
  114,
  115,
  110,
  101,
  112,
  112,
  113,
  120,
  100,
  112,
  118,
  99,
  116,
  119,
  110,
  98,
  98,
  112,
  108,
  98,
  119,
  115,
  113,
  108,
  117,
  118,
  118,
  119,
  102,
  120,
  111,
  103,
  106,
  120,
  119,
  117,
  121,
  102,
  111,
  100,
  106,
  103,
  102,
  119,
  119,
  109,
  97,
  101,
  102,
  98,
  115,
  122,
  99,
  106,
  102,
  106,
  103,
  105,
  102,
  109,
  101,
  114,
  122,
  98,
  103,
  120,
  119,
  112,
  109,
  117,
  103,
  110,
  101,
  119,
  102,
  111,
  109,
  122,
  120,
  116,
  114,
  120,
  111,
  122,
  99,
  107,
  108,
  101,
  106,
  119,
  116,
  113,
  105,
  107,
  113,
  120,
  115,
  110,
  104,
  122,
  107,
  116,
  121,
  106,
  115,
  103,
  109,
  122,
  118,
  111,
  104,
  114,
  110,
  119,
  115,
  114,
  119,
  114,
  119,
  107,
  107,
  109,
  110,
  102,
  109,
  120,
  115,
  107,
  112,
  98,
  113,
  109,
  110,
  100,
  122,
  97,
  105,
  121,
  106,
  100,
  112,
  119,
  113,
  101,
  113,
  122,
  102,
  112,
  105,
  100,
  115,
  122,
  97,
  118,
  116,
  102,
  104,
  97,
  105,
  101,
  103,
  118,
  106,
  116,
  112,
  122,
  118,
  100,
  108,
  98,
  119,
  106,
  98,
  111,
  109,
  110,
  114,
  108,
  103,
  105,
  113,
  111,
  121,
  98,
  121,
  97,
  107,
  118,
  106,
  99,
  107,
  103,
  122,
  110,
  104,
  101,
  113,
  99,
  111,
  119,
  105,
  114,
  111,
  97,
  121,
  119,
  99,
  104,
  114,
  111,
  117,
  117,
  120,
  121,
  115,
  98,
  113,
  101,
  108,
  99,
  120,
  99,
  107,
  115,
  98,
  97,
  97,
  113,
  110,
  122,
  112,
  110,
  122,
  117,
  110,
  111,
  111,
  118,
  101,
  120,
  119,
  113,
  116,
  120,
  112,
  119,
  118,
  113,
  113,
  97,
  111,
  118,
  110,
  115,
  101,
  102,
  97,
  115,
  108,
  121,
  119,
  106,
  109,
  121,
  122,
  105,
  116,
  102,
  120,
  102,
  121,
  104,
  114,
  107,
  98,
  104,
  107,
  105,
  119,
  103,
  122,
  116,
  100,
  100,
  107,
  98,
  101,
  116,
  98,
  98,
  100,
  108,
  111,
  101,
  98,
  102,
  98,
  101,
  122,
  122,
  111,
  118,
  107,
  121,
  106,
  116,
  97,
  121,
  112,
  105,
  102,
  110,
  107,
  117,
  106,
  118,
  102,
  101,
  99,
  120,
  121,
  106,
  98,
  97,
  106,
  110,
  101,
  111,
  104,
  116,
  113,
  114,
  113,
  112,
  116,
  106,
  110,
  98,
  115,
  118,
  98,
  117,
  97,
  114,
  102,
  102,
  100,
  105,
  103,
  110,
  114,
  118,
  114,
  118,
  121,
  108,
  116,
  116,
  101,
  99,
  115,
  104,
  107,
  111,
  111,
  113,
  114,
  99,
  110,
  101,
  98,
  102,
  114,
  109,
  111,
  98,
  106,
  101,
  114,
  103,
  102,
  117,
  106,
  112,
  104,
  97,
  109,
  114,
  97,
  121,
  113,
  107,
  113,
  101,
  104,
  112,
  114,
  117,
  115,
  107,
  113,
  102,
  118,
  117,
  114,
  119,
  104,
  97,
  100,
  117,
  98,
  120,
  117,
  106,
  116,
  113,
  111,
  108,
  121,
  109,
  114,
  117,
  98,
  109,
  106,
  97,
  122,
  116,
  109,
  103,
  122,
  106,
  112,
  106,
  107,
  105,
  121,
  98,
  103,
  108,
  116,
  101,
  115,
  97,
  110,
  116,
  111,
  115,
  114,
  113,
  101,
  118,
  113,
  120,
  112,
  100,
  103,
  102,
  110,
  110,
  113,
  109,
  115,
  119,
  102,
  100,
  113,
  113,
  100,
  114,
  116,
  112,
  112,
  116,
  122,
  100,
  100,
  122,
  99,
  117,
  117,
  104,
  102,
  113,
  101,
  102,
  104,
  117,
  99,
  97,
  119,
  98,
  113,
  109,
  119,
  98,
  113,
  103,
  117,
  117,
  106,
  107,
  99,
  103,
  112,
  116,
  108,
  118,
  103,
  102,
  98,
  98,
  102,
  114,
  102,
  118,
  120,
  97,
  107,
  113,
  102,
  102,
  104,
  107,
  121,
  104,
  111,
  108,
  122,
  103,
  113,
  118,
  104,
  100,
  122,
  117,
  113,
  106,
  108,
  98,
  102,
  109,
  119,
  97,
  117,
  99,
  119,
  118,
  104,
  108,
  116,
  106,
  118,
  106,
  102,
  114,
  101,
  117,
  111,
  99,
  107,
  102,
  101,
  109,
  99,
  117,
  116,
  110,
  120,
  104,
  102,
  104,
  121,
  114,
  114,
  104,
  107,
  110,
  104,
  108,
  112,
  115,
  113,
  97,
  121,
  105,
  121,
  98,
  118,
  115,
  111,
  115,
  118,
  98,
  106,
  114,
  99,
  118,
  97,
  104,
  118,
  98,
  107,
  118,
  99,
  119,
  109,
  108,
  102,
  112,
  99,
  99,
  121,
  99,
  109,
  109,
  110,
  121,
  113,
  97,
  110,
  120,
  108,
  115,
  112,
  106,
  103,
  98,
  100,
  117,
  102,
  98,
  98,
  110,
  113,
  107,
  116,
  100,
  121,
  117,
  103,
  99,
  122,
  98,
  113,
  104,
  107,
  104,
  102,
  97,
  119,
  101,
  116,
  103,
  111,
  104,
  108,
  109,
  119,
  114,
  108,
  102,
  119,
  114,
  122,
  98,
  102,
  109,
  112,
  101,
  98,
  107,
  104,
  106,
  98,
  99,
  116,
  105,
  116,
  104,
  114,
  111,
  117,
  99,
  99,
  110,
  122,
  110,
  107,
  99,
  114,
  115,
  110,
  107,
  100,
  97,
  119,
  102,
  100,
  121,
  108,
  102,
  109,
  111,
  121,
  114,
  108,
  97,
  116,
  117,
  115,
  108,
  102,
  112,
  114,
  101,
  109,
  113,
  118,
  121,
  118,
  111,
  119,
  101,
  114,
  101,
  109,
  119,
  99,
  112,
  102,
  106,
  111,
  97,
  103,
  101,
  107,
  107,
  117,
  112,
  112,
  105,
  121,
  106,
  105,
  111,
  122,
  113,
  118,
  116,
  106,
  114,
  103,
  102,
  115,
  106,
  117,
  107,
  106,
  118,
  110,
  99,
  97,
  100,
  99,
  115,
  103,
  109,
  106,
  107,
  115,
  111,
  113,
  118,
  101,
  113,
  108,
  116,
  118,
  108,
  103,
  120,
  122,
  106,
  99,
  116,
  110,
  100,
  117,
  101,
  104,
  97,
  121,
  103,
  119,
  108,
  99,
  121,
  119,
  99,
  99,
  114,
  110,
  114,
  115,
  102,
  122,
  105,
  111,
  116,
  118,
  112,
  103,
  122,
  109,
  122,
  109,
  115,
  99,
  117,
  106,
  119,
  109,
  99,
  108,
  116,
  120,
  102,
  115,
  113,
  111,
  112,
  121,
  115,
  117,
  119,
  108,
  115,
  121,
  117,
  109,
  110,
  122,
  107,
  117,
  118,
  122,
  117,
  122,
  113,
  109,
  97,
  108,
  104,
  115,
  107,
  101,
  112,
  118,
  121,
  116,
  106,
  122,
  121,
  117,
  98,
  118,
  113,
  99,
  110,
  98,
  120,
  113,
  115,
  120,
  118,
  115,
  108,
  108,
  114,
  119,
  108,
  116,
  106,
  111,
  97,
  104,
  115,
  98,
  120,
  122,
  116,
  107,
  103,
  111,
  104,
  110,
  110,
  107,
  99,
  101,
  120,
  117,
  118,
  100,
  97,
  112,
  100,
  107,
  100,
  110,
  114,
  109,
  104,
  105,
  112,
  101,
  110,
  116,
  109,
  97,
  112,
  121,
  112,
  107,
  113,
  115,
  104,
  116,
  99,
  110,
  115,
  118,
  98,
  107,
  108,
  111,
  108,
  121,
  114,
  111,
  109,
  104,
  111,
  107,
  120,
  103,
  108,
  112,
  114,
  107,
  114,
  122,
  107,
  104,
  104,
  119,
  103,
  119,
  122,
  97,
  110,
  102,
  98,
  98,
  104,
  103,
  113,
  110,
  104,
  122,
  122,
  116,
  97,
  115,
  97,
  120,
  106,
  114,
  104,
  108,
  116,
  108,
  103,
  97,
  104,
  112,
  117,
  119,
  115,
  98,
  113,
  112,
  119,
  108,
  120,
  105,
  103,
  122,
  98,
  121,
  100,
  101,
  113,
  119,
  98,
  121,
  115,
  119,
  120,
  120,
  103,
  118,
  103,
  119,
  109,
  100,
  120,
  98,
  108,
  103,
  103,
  121,
  111,
  101,
  98,
  117,
  113,
  120,
  106,
  111,
  108,
  107,
  98,
  119,
  117,
  107,
  116,
  117,
  113,
  121,
  120,
  117,
  100,
  99,
  109,
  98,
  120,
  121,
  117,
  115,
  97,
  98,
  110,
  104,
  115,
  99,
  120,
  100,
  103,
  120,
  103,
  101,
  115,
  97,
  115,
  109,
  104,
  118,
  104,
  107,
  110,
  114,
  109,
  105,
  116,
  103,
  107,
  115,
  108,
  107,
  110,
  106,
  105,
  115,
  100,
  109,
  103,
  118,
  121,
  105,
  109,
  116,
  122,
  100,
  98,
  116,
  119,
  111,
  101,
  113,
  105,
  113,
  99,
  112,
  116,
  103,
  104,
  121,
  107,
  121,
  109,
  106,
  106,
  120,
  108,
  111,
  97,
  105,
  119,
  119,
  102,
  101,
  119,
  103,
  110,
  107,
  102,
  104,
  122,
  116,
  122,
  103,
  106,
  106,
  98,
  118,
  110,
  112,
  120,
  122,
  122,
  98,
  119,
  97,
  122,
  118,
  116,
  109,
  107,
  102,
  105,
  109,
  119,
  103,
  117,
  113,
  101,
  99,
  112,
  107,
  117,
  102,
  107,
  120,
  117,
  97,
  101,
  118,
  103,
  107,
  113,
  103,
  105,
  114,
  109,
  110,
  112,
  97,
  118,
  99,
  118,
  119,
  114,
  100,
  113,
  122,
  99,
  109,
  113,
  118,
  105,
  119,
  99,
  118,
  120,
  108,
  113,
  0
];

final testFileHash = [
  142,
  252,
  10,
  230,
  71,
  134,
  191,
  96,
  33,
  72,
  42,
  16,
  99,
  185,
  150,
  242,
  228,
  245,
  21,
  169,
  15,
  175,
  71,
  245,
  191,
  128,
  35,
  189,
  120,
  37,
  101,
  149,
  144,
  164,
  61,
  15,
  147,
  19,
  98,
  201,
  177,
  9,
  28,
  126,
  59,
  224,
  83,
  101
];

final testFileHashSmaller = [
  82,
  86,
  59,
  100,
  229,
  102,
  122,
  217,
  23,
  171,
  40,
  200,
  207,
  133,
  136,
  94,
  65,
  123,
  193,
  87,
  76,
  61,
  202,
  179,
  57,
  59,
  163,
  250,
  56,
  212,
  70,
  23,
  73,
  6,
  0,
  38,
  173,
  229,
  197,
  19,
  82,
  102,
  211,
  99,
  93,
  183,
  70,
  104,
];
