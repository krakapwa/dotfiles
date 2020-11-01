require 'rake'
require 'erb'

IGNORE = %w[
  Rakefile
  base.png
  README.md
].freeze
desc "install the dot files into user's home directory"
task :test do
  install_fonts
end

task :install do
  replace_all = false
  files = Dir['*'] - %w[Rakefile README.rdoc LICENSE oh-my-zsh]
  files.each do |file|
    system %Q{mkdir -p "$HOME/.#{File.dirname(file)}"} if file =~ /\//
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}")
        puts "identical ~/.#{file.sub(/\.erb$/, '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub(/\.erb$/, '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub(/\.erb$/, '')}"
        end
      end
    else
      link_file(file)
    end
  end
  copy_swapescape
  install_packages
  install_oh_my_zsh
  install_gtk_theme
  install_vim
  switch_to_zsh
  x_screen_tearing_fix
  install_fonts
  init_emacsd_service
  install_doom
  install_regolith
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub(/\.erb$/, '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub(/\.erb$/, '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

def install_packages
  packages = %w{
        emacs gconf2 dconf-cli uuid-runtime xfce4-terminal ripgrep
      }
      sh "sudo apt-get install #{packages * ' '}"
end

def switch_to_zsh
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{sudo apt install zsh}
      system %Q{chsh -s $(which zsh)}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end

def install_regolith
  system %Q{sudo add-apt-repository ppa:regolith-linux/release}
  system %Q{sudo apt update}
  system %Q{sudo apt install regolith-desktop i3xrocks-net-traffic i3xrocks-cpu-usage i3xrocks-time i3xrocks-battery}
end

def install_gtk_theme
  url = "https://github.com/dracula/gtk/archive/master.zip"
  puts "downloading gtk theme: .#{url}"
  system %Q{wget #{url} -O gtk-theme.zip}
  if(Dir.exist?('~/.themes'))
    puts 'themes.d already exists'
  else
    system %Q{mkdir ~/.themes}
    if(Dir.exist?('~/.themes.d/dracula'))
      puts 'themes.d/dracula already exists'
    else
      system %Q{unzip gtk-theme.zip && mv gtk-master ~/.themes/dracula}
    end
  end

  system %Q{sudo add-apt-repository ppa:snwh/ppa}
  system %Q{sudo apt update}
  system %Q{sudo apt install paper-icon-theme}
end

def install_doom
  url_doom = "https://github.com/hlissner/doom-emacs"

  if(Dir.exist?('~/.emacs.d'))
    puts 'emacs.d already exists'
  else
    puts 'downloading doom emacs'
    system %Q{git clone --depth 1 #{url_doom} ~/.emacs.d}
    system %Q{~/.emacs.d/bin/doom install}
  end

end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    puts "found ~/.oh-my-zsh"
  else
    print "install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing oh-my-zsh"
      system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
    when 'q'
      exit
    else
      puts "skipping oh-my-zsh, you will need to change ~/.zshrc"
    end
  end
end

def install_vim
  print "install spf13-vim? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing spf13-vim"
      system %Q{curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh}
    when 'q'
      puts "skipping spf13-vim"
      exit
    end
end

def install_fonts
  print "install fonts? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing nerd fonts"
      system %Q{mkdir fonts}
      system %Q{wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip}
      system %Q{mv JetBrainsMono.zip fonts/}
      system %Q{cd fonts && unzip JetBrainsMono.zip}
      system %Q{fc-cache -fv}
    when 'q'
      puts "skipping fonts"
      exit
    end
end

def x_screen_tearing_fix
  print "add screen tearing fix to X11? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing"
      system %Q{sudo ln -s $PWD/92-nvidia.conf /etc/X11/xorg.conf.d/92-nvidia.conf}
    when 'q'
      puts "skipping"
      exit
    end
end

def gsettings_swapescape
  print "apply gsettings conf to swap capslock and escape? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "applying xkb-options through gsettings"
      system %Q{gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"}
    when 'q'
      puts "skipping"
      exit
    end
end

def copy_swapescape
  print "install xorg config to swap capslock and escape? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing"
      system %Q{sudo ln -s $PWD/91-swapesc.conf /etc/X11/xorg.conf.d/91-swapesc.conf}
    when 'q'
      puts "skipping"
      exit
    end
end

def init_emacsd_service
  print "enable emacs daemon service? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "enabling/starting emacs daemon"
      system %Q{systemctl --user enable emacs}
      system %Q{systemctl --user start emacs}
    when 'q'
      puts "skipping"
      exit
    end
end
