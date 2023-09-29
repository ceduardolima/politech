# politech
---

1. Usar apenas a branch develop
2. Sempre que for criar novas funcionalidades, crie um branch específica para isso.
    - Para criar uma branch nova useo comando: **git checkout -b nome_da_branch**. Com esse comando, a nova branch será criada com base na brach que você estar.
    - Nós teremos as seguintes convenções para nomear as branchs:
      * Novas funcionalidades: **funcionalidade/nome_da_branch**
      * para resolução de bugs: **bugfix/nome_da_branch**  
3. Os commits devem claros, não tem problema se forem grandes mas precisam descrever o que você fez. De preferência, faça commits com poucas mudanças.
4. Sempre faça PullRequest. Para fazer uma pull request, primeiro você finaliza a funcionalidade que você fez. Após isso, na branch da sua funcionalidade você digita o commando **git push -u origin nome_da_sua_branch** para enviar a sua branch para o repositório remoto. Após isso, você vai para o github e criar um PR me assinando. E lembre-se, sempre coloque a PR para fazer o merge no branch **develop**.
    
