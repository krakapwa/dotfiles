require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :test do
  init_emacsd_service
end

task :install do
  copy_swapescape
  install_oh_my_zsh
  install_vim
  switch_to_zsh
  install_fonts
  replace_all = false
  files = Dir['*'] - %w[Rakefile README.rdoc LICENSE oh-my-zsh]
  files << "oh-my-zsh/custom/plugins/rbates"
  files << "oh-my-zsh/custom/rbates.zsh-theme"
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

def switch_to_zsh
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
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
  print "install powerline fonts? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing powerline fonts"
      system %Q{git clone https://github.com/powerline/fonts.git --depth=1}
      system %Q{cd fonts && sh install.sh}
    when 'q'
      puts "skipping powerline fonts"
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
      system %Q{systemctl --user enable emacsd}
      system %Q{systemctl --user start emacsd}
    when 'q'
      puts "skipping"
      exit
    end
end
