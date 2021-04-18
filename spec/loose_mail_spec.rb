RSpec.describe LooseMail do
  it "has a version number" do
    expect(LooseMail::VERSION).not_to be nil
  end

  describe 'MIME encoded' do
    it_is_asserted_by { Mail.read_from_string('Subject: =?utf-8?q?a?= =?utf-8?q?b?=').subject == 'ab' }
    it_is_asserted_by { Mail.read_from_string('Subject: =?utf-8?q?a?==?utf-8?q?b?=').subject == 'ab' }
    it_is_asserted_by { Mail.read_from_string('Subject: =?utf-8?q?a?= b =?utf-8?q?c?=').subject == 'a b c' }
    it_is_asserted_by { Mail.read_from_string('Subject: =?iso-2022-jp?q?=1B$B$"-!#0-j=1B(B?=').subject == 'あ①０㈱' }
    it_is_asserted_by { Mail.read_from_string('Subject: =?iso-2022-jp?q?=1B$B$"=1B(I1=1B(B?=').subject == 'あｱ' }
    it_is_asserted_by { Mail.read_from_string('Subject: =?utf-8?q?=E3=81?= =?utf-8?q?=82?=').subject == 'あ' }
    it_is_asserted_by { Mail.read_from_string('Subject: =?utf-8?B?44E=?= =?UTF-8?B?guM=?= =?utf-8?b?gYQ=?=').subject == 'あい' }
    it_is_asserted_by { Mail.read_from_string('Subject: =?utf-8?q?=FF?=').subject == '�' }
  end

  describe 'attachment filename' do
    msg = <<~MAIL
      Content-Type: multipart/mixed; boundary=12345

      --12345
      X-Content-Disposition: attachment; filename="=?utf-8?q?abc?="
      Content-Disposition: attachment; filename="=?iso-2022-jp?q?=1B$B$\\"-!#0-j=1B(B?="
      --12345--
    MAIL
    it_is_asserted_by { Mail.read_from_string(msg).parts[0].filename == 'あ①０㈱' }
  end

  describe 'body charset iso-2022-jp' do
    msg = <<~MAIL
      Content-Type: text/plain; charset=iso-2022-jp

      \e$B$\"-!#0-j\e(B
    MAIL
    it_is_asserted_by { Mail.read_from_string(msg).decoded == "あ①０㈱\n" }
  end
end
