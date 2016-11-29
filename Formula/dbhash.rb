class Dbhash < Formula
  desc "Computes the SHA1 hash of schema and content of a SQLite database"
  homepage "https://www.sqlite.org/dbhash.html"
  url "https://www.sqlite.org/2016/sqlite-src-3150200.zip"
  version "3.15.2"
  sha256 "38a1e867b5b1a58ba3731a63ffe69a2271d79bd0723d21c5a9a71e4cb7452a83"

  bottle do
    cellar :any_skip_relocation
    sha256 "bec0dbda19d83e979bafe860acce6c033738ab51ed405170a45f9251521ed23f" => :sierra
    sha256 "b97e3a56dc98d13915f09fc2d11d06f36a77a1de00440d6888ab54dd62439dbc" => :el_capitan
    sha256 "d0360980ce4883e34925178486395587abc3721efb53a4b404fc914f26b9be86" => :yosemite
  end

  def install
    system "./configure", "--disable-debug", "--prefix=#{prefix}"
    system "make", "dbhash"
    bin.install "dbhash"
  end

  test do
    dbpath = testpath/"test.sqlite"
    sqlpath = testpath/"test.sql"
    sqlpath.write "create table test (name text);"
    system "/usr/bin/sqlite3 #{dbpath} < #{sqlpath}"
    assert_equal "b6113e0ce62c5f5ca5c9f229393345ce812b7309",
                 shell_output("#{bin}/dbhash #{dbpath}").strip.split.first
  end
end
